import Foundation

final class Services {
    let placesService: PlacesService
    
    init(
        placesService: PlacesService
    ) {
        self.placesService = placesService
    }
}

extension Services {
    convenience init() {
        let placesService = ProductionPlacesService()

        self.init(
            placesService: placesService
        )
    }
}

// MARK: - Mocks

extension Services {
    static let mock = Services(
        placesService: MockPlacesService()
    )
}
