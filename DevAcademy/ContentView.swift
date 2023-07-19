import SwiftUI

struct ContentView: View {
    var body: some View {
        PlacesScene(placesSceneState: PlacesSceneState(dataService: .shared))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
