import SwiftUI

@main
struct DevAcademyApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(FeaturesObservableObject())
                .environmentObject(Coordinator())
        }
    }
}
