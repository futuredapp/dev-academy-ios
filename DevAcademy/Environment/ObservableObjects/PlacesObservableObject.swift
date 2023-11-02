import Foundation
import CoreLocation

final class PlacesObservableObject: ObservableObject {
    @Published var places: [Place] = []
    
    private(set) var favouritePlaces: [Int]? {
        get { UserDefaults.standard.array(forKey: "favourites") as? [Int] }
        set {
            UserDefaults.standard.set(newValue, forKey: "favourites")
            updatePlaces()
        }
    }
    
    private var rawPlaces: [Place] = [] {
        didSet { updatePlaces() }
    }
    private let placesService: PlacesService
    private let locationService: UserLocationService
    private let coreDataService: CoreDataService
    private var lastUpdatedLocation: CLLocation?
    
    
    init(placesService: PlacesService, locationService: UserLocationService, coreDataService: CoreDataService) {
        self.placesService = placesService
        self.locationService = locationService
        self.coreDataService = coreDataService
        
        self.locationService.listenDidUpdateLocation { [weak self] location in
            DispatchQueue.main.async {
                self?.locationDidUpdate(location: location)
            }
        }
        
        self.locationService.listenDidUpdateStatus { [weak self] status in
            switch status {
            case .notDetermined:
                self?.locationService.requestAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                self?.beginLocationUpdates()
            default: break
            }
        }
    }
    
    func set(place: Place, favourite setFavourite: Bool) {
        var favouritePlaces = self.favouritePlaces ?? []
        let currentIndex = favouritePlaces.firstIndex(of: place.attributes.ogcFid)
        
        switch (setFavourite, currentIndex) {
        case (true, nil):
            favouritePlaces.append(place.attributes.ogcFid)
        case (false, let index?):
            favouritePlaces.remove(at: index)
        default:
            return
        }
        
        self.favouritePlaces = favouritePlaces
    }
    
    // A. Closure variant
    func fetchPlaces() {
        placesService.places { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    self.rawPlaces = places.places
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // B. Async with checked continuation variant
    func fetchPlacesWithCheckedContinuation() async {
        let result = await placesService.placesWithCheckedContinuation()
        switch result {
        case .success(let places):
            DispatchQueue.main.async {
                self.rawPlaces = places.places
            }
        case .failure(let error):
            print(error)
        }
    }
    
    // C. Async variant
    @MainActor
    func fetchPlacesWithAsync() async {
        do {
            let placesResult = try await placesService.placesWithAsync()
            self.rawPlaces = placesResult.places
        } catch {
            print(error)
        }
    }
    
    private func updatePlaces() {
        var regularPlaces = rawPlaces
        
        if let lastUpdatedLocation {
            regularPlaces.sort { lPlace, rPlace in
                guard let rPoint = rPlace.geometry?.cllocation else {
                    return false
                }
                guard let lPoint = lPlace.geometry?.cllocation else {
                    return true
                }
                
                return lastUpdatedLocation.distance(from: lPoint).magnitude < lastUpdatedLocation.distance(from: rPoint).magnitude
            }
        }
        
        var presentOnTop: [Place] = []
        let favouritePlaces = self.favouritePlaces ?? []
        
        regularPlaces.removeAll { place in
            if favouritePlaces.contains(place.attributes.ogcFid) {
                presentOnTop.append(place)
                return true
            } else {
                return false
            }
        }
        
        self.places = presentOnTop + regularPlaces
    }
    
    private func shouldUpdate(location: CLLocation) -> Bool {
        lastUpdatedLocation.flatMap { $0.distance(from: location).magnitude > 500 } ?? true
    }
    
    private func beginLocationUpdates() {
        self.locationService.startUpdatingLocation()
    }
    
    private func locationDidUpdate(location: [CLLocation]) {
        guard let userLocation = location.first, shouldUpdate(location: userLocation) else { return }
        self.lastUpdatedLocation = userLocation
        updatePlaces()
    }
    
    func loadNote(forPlace ogcFid: Int) -> String? {
        coreDataService.loadNote(forPlace: ogcFid)
    }
    
    func save(note: String?, forPlace ogcFid: Int) {
        coreDataService.save(note: note, forPlace: ogcFid)
    }
}
