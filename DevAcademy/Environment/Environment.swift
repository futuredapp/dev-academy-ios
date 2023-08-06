import SwiftUI

private struct Environment: ViewModifier {
    let objects: ObservableObjects
    let coordinator: Coordinator

    func body(content: Content) -> some View {
        content
            .environmentObject(objects.features)
            .environmentObject(coordinator)
    }
}

extension View {
    func inject(objects: ObservableObjects, coordinator: Coordinator) -> some View {
        modifier(Environment(objects: objects, coordinator: coordinator))
    }

    func injectPreviewsEnvironment() -> some View {
        modifier(Environment(objects: .mock, coordinator: Coordinator()))
    }
}
