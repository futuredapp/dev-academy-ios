import SwiftUI

struct PlacesViewState: DynamicProperty {
    @EnvironmentObject private var featuresObject: FeaturesObservableObject
    
    @State var showFavorites = false
    
    var features: [Feature] {
        featuresObject.features
    }
    
    var featuresAreLoaded: Bool {
        !features.isEmpty
    }
    
    func fetch() {
        featuresObject.fetchFeatures()
    }
    
    func favoritesPressed() {
        showFavorites = true
    }
}
