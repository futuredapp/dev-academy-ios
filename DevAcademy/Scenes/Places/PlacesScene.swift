import SwiftUI

struct PlacesScene: View {
    @State var features: [Feature] = []

    var body: some View {
        NavigationStack {
            Group {
                if !features.isEmpty {
                    List(features, id: \.properties.nazev) { feature in
                        PlaceRow(feature: feature)
                            .onTapGesture {
                                tapped(on: feature)
                            }
                    }
                    .listStyle(.plain)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Kultůrmapa")
        }
        .onAppear {
            fetch()
        }
    }

    func tapped(on feature: Feature) {
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
