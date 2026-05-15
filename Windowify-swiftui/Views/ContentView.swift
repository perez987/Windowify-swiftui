import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WindowifyViewModel
    @State private var isDropTarget = false

    var body: some View {
        HSplitView {
            AttributeListView(viewModel: viewModel)
            ImagePreviewPane(
                image: viewModel.image,
                imageURL: viewModel.imageURL,
                isDropTarget: isDropTarget
            )
            .padding()
        }
        .dropDestination(for: URL.self) { urls, _ in
            guard let url = urls.first else { return false }
            viewModel.loadImage(from: url)
            return true
        } isTargeted: { targeted in
            isDropTarget = targeted
        }
        .frame(minWidth: 800, idealWidth: 800, maxWidth: 800, minHeight: 400, idealHeight: 400, maxHeight: 400)
    }
}
