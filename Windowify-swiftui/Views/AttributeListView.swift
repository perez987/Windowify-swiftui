import SwiftUI

struct AttributeListView: View {
    @ObservedObject var viewModel: WindowifyViewModel
    
    private var minimalBinding: Binding<Bool> {
        Binding(
            get: { viewModel.attributes.isMinimal },
            set: { isMinimal in
                viewModel.setMinimalEnabled(isMinimal)
            }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Window title")
                .font(.headline)
            TextField("Window title", text: $viewModel.title)
            Button("Update Preview") {
                viewModel.updatePreviewWindow()
            }
            .disabled(!viewModel.canRefreshPreview)
            .accessibilityLabel("Update preview window")
            .accessibilityHint("Update preview to show current title and attribute changes.")
            
            Text("Attributes")
                .font(.headline)
            
            List {
                    Toggle("closable", isOn: $viewModel.attributes.closable)
                    Toggle("miniaturizable", isOn: $viewModel.attributes.miniaturizable)
                    Toggle("resizable", isOn: $viewModel.attributes.resizable)
                    Toggle("titlebarAppearsTransparent", isOn: $viewModel.attributes.titlebarAppearsTransparent)
                    Toggle("closeButtonHidden", isOn: $viewModel.attributes.closeButtonHidden)
                    Toggle("miniaturizeButtonHidden", isOn: $viewModel.attributes.miniaturizeButtonHidden)
                    Toggle("zoomButtonHidden", isOn: $viewModel.attributes.zoomButtonHidden)
                    Toggle("--minimal", isOn: minimalBinding)
                }
            .listStyle(.plain)
            }
            .padding()
            .frame(minWidth: 360, idealWidth: 360, maxWidth: 360)
        }
    }
