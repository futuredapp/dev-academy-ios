import Foundation

final class PlacesObservableObject: ObservableObject {
    @Published var place: [Place] = []
    
    private let dataService: DataService = DataService.shared
    
    func fetchFeatures() {
        dataService.fetchData { result in
            switch result {
            case .success(let places):
                self.place = places.places
            case .failure(let error):
                print(error)
            }
        }
    }    
}
