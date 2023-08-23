import SwiftUI

struct PlacesViewState: DynamicProperty {
    @EnvironmentObject private var placesObject: PlacesObservableObject
    
    @State var showFavorites = false
    
    var places: [Place] {
        placesObject.places
    }
    
    var featuresAreLoaded: Bool {
        !places.isEmpty
    }
    
    // A. Closure variant
    func fetch() {
        placesObject.fetchPlaces()
    }

    // B. Async with checked continuation variant
    func fetchPlacesWithCheckedContinuation() async {
        await placesObject.fetchPlacesWithCheckedContinuation()
    }

    // C. Async variant
    func fetchPlacesWithAsync() async {
        await placesObject.fetchPlacesWithAsync()
    }
    
    func favoritesPressed() {
        showFavorites = true
    }
}
