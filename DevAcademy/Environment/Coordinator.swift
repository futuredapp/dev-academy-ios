import SwiftUI

final class Coordinator: ObservableObject {

    // MARK: - Places scenes
    var placesScene: some View {
        PlacesView()
    }

    func placeDetailScene(with feature: Feature) -> some View {
        PlaceDetailView(state: PlaceDetailViewState(feature: feature))
    }
}
