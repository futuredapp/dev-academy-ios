import Foundation

final class Services {
    let placesService: PlacesService
    let locationService: UserLocationService
    
    init(
        placesService: PlacesService,
        locationService: UserLocationService
    ) {
        self.placesService = placesService
        self.locationService = locationService
    }
}

extension Services {
    convenience init() {
        let placesService = ProductionPlacesService()
        let locationService = ProductionUserLocationService()

        self.init(
            placesService: placesService,
            locationService: locationService
        )
    }
}

// MARK: - Mocks

extension Services {
    static let mock = Services(
        placesService: MockPlacesService(),
        locationService: MockLocationService()
    )
}
