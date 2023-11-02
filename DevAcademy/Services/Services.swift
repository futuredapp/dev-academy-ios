import Foundation

final class Services {
    let placesService: PlacesService
    let locationService: UserLocationService
    let coreDataService: CoreDataService
    
    init(
        placesService: PlacesService,
        locationService: UserLocationService,
        coreDateService: CoreDataService
    ) {
        self.placesService = placesService
        self.locationService = locationService
        self.coreDataService = coreDateService
    }
}

extension Services {
    convenience init() {
        let placesService = ProductionPlacesService()
        let locationService = ProductionUserLocationService()
        let coreDataService = ProductionsCoreDataService()

        self.init(
            placesService: placesService,
            locationService: locationService,
            coreDateService: coreDataService
        )
    }
}

// MARK: - Mocks

extension Services {
    static let mock = Services(
        placesService: MockPlacesService(),
        locationService: MockLocationService(),
        coreDateService: MockCoreDataService()
    )
}
