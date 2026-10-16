import SwiftUI

@main
struct WindowifyApp: App {
    @StateObject private var viewModel = WindowifyViewModel()
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup("Windowify-swiftui (based on windowify by Valerian Galliat)") {
            ContentView(viewModel: viewModel)
        }
        .windowResizability(.contentSize) // not resizable window
        .commands {
            WindowifyCommands(viewModel: viewModel)
        }
    }
}
