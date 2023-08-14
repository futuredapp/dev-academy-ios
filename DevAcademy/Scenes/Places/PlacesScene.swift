import SwiftUI
import ActivityIndicatorView

struct PlacesScene: View {
    @State var features: [Feature] = []
    @State var showFavorites = false

    var body: some View {
        NavigationStack {
            Group {
                if !features.isEmpty {
                    List(features, id: \.properties.nazev) { feature in
                        NavigationLink(destination: PlaceDetail(feature: feature)) {
                            PlaceRow(feature: feature)
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
                    Button("Oblíbené") {
                        showFavorites = true
                    }
                }
            }
        }
        .onAppear(perform: fetch)
        .sheet(isPresented: $showFavorites) {
            Text("Zatím tady nic není")
        }
    }

    func fetch() {
        DataService.shared.fetchData { result in
            switch result {
            case .success(let features):
                self.features = features.features
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct PlacesScene_Previews: PreviewProvider {
    static var previews: some View {
        PlacesScene()
    }
}
