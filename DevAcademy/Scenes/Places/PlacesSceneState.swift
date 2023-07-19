import SwiftUI

class PlacesSceneState: ObservableObject {
    let dataService: DataService

    @Published var features: Features = Features(features: [])
    @Published var error: Error?

    init(dataService: DataService) {
        self.dataService = dataService
    }

    func loadData() {
        error = nil
        features = Features(features: [])

        dataService.fetchData { result in
            switch result {
            case let .success(data):
                self.features = data
            case let .failure(error):
                self.error = error
            }
        }
    }
}
