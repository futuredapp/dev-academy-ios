import SwiftUI
import ActivityIndicatorView

struct PlacesView: View {
    @State var places: [Place] = []
    @State var showFavorites = false

    var body: some View {
        NavigationStack {
            Group {
                if !places.isEmpty {
                    List(places, id: \.properties.nazev) { place in
                        NavigationLink(destination: PlaceDetailView(place: place)) {
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
            case .success(let places):
                self.places = places.places
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}
