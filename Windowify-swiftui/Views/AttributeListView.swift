import SwiftUI

struct AttributeListView: View {
    @ObservedObject var viewModel: WindowifyViewModel

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

            Text("Window style")
                .font(.headline)

            Picker("Window style", selection: $viewModel.selectedMode) {
                ForEach(WindowMode.allCases) { mode in
                    Text(LocalizedStringKey(mode.labelKey)).tag(mode)
                }
            }
            .pickerStyle(.radioGroup)
            .labelsHidden()

            Spacer(minLength: 0)
        }
        .padding()
        .frame(minWidth: 380, idealWidth: 380, maxWidth: 380, maxHeight: .infinity, alignment: .topLeading)
    }
}
