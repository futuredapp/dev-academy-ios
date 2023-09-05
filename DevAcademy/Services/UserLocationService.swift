import Combine
import CoreLocation

protocol UserLocationService {
    var locationServicesEnabled: Bool { get }
    var authorizationStatus: CLAuthorizationStatus { get }
    var userLocation: CLLocation? { get }
    
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestAuthorization()

    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void)
    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void)
}

final class ProductionUserLocationService: NSObject, UserLocationService {

    private let manager = CLLocationManager()
    private var stateChangeHandler: ((CLAuthorizationStatus) -> Void)?
    private var locationChangeHandler: (([CLLocation]) -> Void)?
    
    var locationServicesEnabled: Bool {
        CLLocationManager.locationServicesEnabled()
    }

    var authorizationStatus: CLAuthorizationStatus {
        manager.authorizationStatus
    }

    var userLocation: CLLocation? {
        manager.location
    }

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }

    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void) {
        self.locationChangeHandler = handler
    }


    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }

    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }

    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void) {
        self.stateChangeHandler = handler
        handler(manager.authorizationStatus)
    }
}

extension ProductionUserLocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.stateChangeHandler?(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationChangeHandler?(locations)
    }
}

final class MockLocationService: UserLocationService {
    
    var locationServicesEnabled: Bool { false }
    var authorizationStatus: CLAuthorizationStatus { .denied }
    var userLocation: CLLocation? { nil }
    
    func startUpdatingLocation() { /* nop */ }
    func stopUpdatingLocation() { /* nop */ }
    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void) { /* nop */ }
    func requestAuthorization() { /* nop */ }
    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void) { /* nop */ }
}
