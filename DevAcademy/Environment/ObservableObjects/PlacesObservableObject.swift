import Foundation

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
    
    init(placesService: PlacesService) {
        self.placesService = placesService
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
}
