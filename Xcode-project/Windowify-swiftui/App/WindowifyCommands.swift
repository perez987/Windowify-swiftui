import SwiftUI

struct WindowifyCommands: Commands {
    @ObservedObject var viewModel: WindowifyViewModel

    var body: some Commands {
        CommandGroup(replacing: .newItem) {}
        CommandGroup(after: .newItem) {
            Button("Open…") { viewModel.openImagePanel() }
                .keyboardShortcut("o", modifiers: .command)
        }
        CommandGroup(replacing: .help) {}
    }
}
