import Foundation

final class FeaturesObservableObject: ObservableObject {
    @Published var features: [Feature] = []
    
    private let dataService: DataService = DataService.shared
    
    func fetchFeatures() {
        dataService.fetchData { result in
            switch result {
            case .success(let features):
                self.features = features.features
            case .failure(let error):
                print(error)
            }
        }
    }    
}
