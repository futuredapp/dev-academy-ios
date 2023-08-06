import Foundation

// MARK: - ObservableObjects

final class ObservableObjects {
    let features: FeaturesObservableObject
    
    init(
        features: FeaturesObservableObject
    ) {
        self.features = features
    }
}

// MARK: - ObservableObjects + Extension

extension ObservableObjects {
    convenience init(services: Services) {
        let features = FeaturesObservableObject()
        
        self.init(
            features: features
        )
    }
}

// MARK: - Mocks

extension ObservableObjects {
    static let mock: ObservableObjects = ObservableObjects(services: .mock)
}
