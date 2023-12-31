import Foundation

final class PlacesObservableObject: ObservableObject {
    @Published var places: [Place] = []
    
    private let placesService: PlacesService
    
    init(placesService: PlacesService) {
        self.placesService = placesService
    }
    
    // A. Closure variant
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

    // B. Async with checked continuation variant
    func fetchPlacesWithCheckedContinuation() async {
        let result = await placesService.placesWithCheckedContinuation()
        switch result {
        case .success(let places):
            DispatchQueue.main.async {
                self.places = places.places
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
            self.places = placesResult.places
        } catch {
            print(error)
        }
    }
}
