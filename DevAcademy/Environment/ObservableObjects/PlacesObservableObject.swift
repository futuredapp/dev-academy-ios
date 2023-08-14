import Foundation

final class PlacesObservableObject: ObservableObject {
    @Published var places: [Place] = []
    
    private let placesService: PlacesService
    
    init(placesService: PlacesService) {
        self.placesService = placesService
    }
    
    func fetchPlaces() {
        placesService.places { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    self.places = places.places
                }
            case .failure(let error):
                print(error)
            }
        }
    }    
}
