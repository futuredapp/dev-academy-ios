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
    
    func fetch() {
        placesObject.fetchPlaces()
    }

    func fetchPlacesWithCheckedContinuation() async {
        await placesObject.fetchPlacesWithCheckedContinuation()
    }

    func fetchPlacesWithAsync() async {
        await placesObject.fetchPlacesWithAsync()
    }
    
    func favoritesPressed() {
        showFavorites = true
    }
}
