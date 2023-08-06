import SwiftUI
import MapKit

struct PlaceDetailViewState: DynamicProperty {
    private let feature: Feature
    
    init(feature: Feature) {
        self.feature = feature
    }
    
    var placeTitle: String {
        feature.properties.nazev
    }
    
    var placeType: String {
        feature.properties.druh.rawValue
    }
    
    var placeImageUrl: URL {
        feature.properties.obrId1
    }
    
    var placeCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: feature.geometry.latitude, longitude: feature.geometry.longitude)
    }
}

