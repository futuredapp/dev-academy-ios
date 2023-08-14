import SwiftUI
import MapKit

struct PlaceDetailViewState: DynamicProperty {
    private let place: Place
    
    init(place: Place) {
        self.place = place
    }
    
    var placeTitle: String {
        place.attributes.name
    }
    
    var placeType: String {
        place.attributes.type.rawValue
    }
    
    var placeImageUrl: URL? {
        place.attributes.imageUrl
    }
    
    var placeCoordinate: CLLocationCoordinate2D? {
        guard let latitude = place.geometry?.latitude, let longitude = place.geometry?.longitude else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

