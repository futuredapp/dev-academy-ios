import SwiftUI

struct RootView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        coordinator.placesScene
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
