import SwiftUI

struct PlacesScene: View {
    @ObservedObject var placesSceneState: PlacesSceneState

    var body: some View {
        NavigationView {
            Group {
                if !placesSceneState.features.features.isEmpty {
                    List(placesSceneState.features.features, id: \.properties.nazev) { feature in
                        PlaceRow(feature: feature)
                    }
                    .listStyle(.plain)

                } else if let error = placesSceneState.error {
                    Text(error.localizedDescription)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Kultůrmapa")
            .onAppear(perform: placesSceneState.loadData)
        }
    }
}

struct PlacesScene_Previews: PreviewProvider {
    static var previews: some View {
        PlacesScene(placesSceneState: PlacesSceneState(dataService: .shared))
    }
}
