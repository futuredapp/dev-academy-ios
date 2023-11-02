import SwiftUI
import ActivityIndicatorView

struct PlacesView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    let state = PlacesViewState()

    var body: some View {
        NavigationStack {
            Group {
                if state.featuresAreLoaded {
                    List(state.places, id: \.attributes.name) { place in
                        NavigationLink(destination: coordinator.placeDetailScene(with: place)) {
                            PlaceRow(place: place)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    ActivityIndicatorView(isVisible: .constant(true), type: .growingCircle)
                }
            }
            .navigationTitle("Kultůrmapa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Oblíbené", action: state.favoritesPressed)
                }
            }
        }
        // A. Closure variant
        .onAppear(perform: state.fetch)
//        .task {
//        // B. Async with checked continuation variant
//            await state.fetchPlacesWithCheckedContinuation()
//        // C. Async variant
//            await state.fetchPlacesWithAsync()
//        }
        .sheet(isPresented: state.$showFavorites) {
            coordinator.favoritesScene
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
            .injectPreviewsEnvironment()
    }
}
