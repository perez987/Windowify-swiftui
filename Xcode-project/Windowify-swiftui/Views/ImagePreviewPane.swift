import AppKit
import SwiftUI

struct ImagePreviewPane: View {
    private enum UIConstants {
        static let dropTargetOpacity: Double = 0.18
        static let idleDropZoneOpacity: Double = 0.08
    }

    let image: NSImage?
    let imageURL: URL?
    let isDropTarget: Bool

    var body: some View {
        VStack(spacing: 16) {
            Group {
                if let image {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(24)
                } else {
                    VStack(spacing: 10) {
                        Text("Drag a PNG or JPEG image here")
                        Text("or use File → Open… (⌘O)")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .background(
                isDropTarget
                    ? Color.accentColor.opacity(UIConstants.dropTargetOpacity)
                    : Color.secondary.opacity(UIConstants.idleDropZoneOpacity)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(
                        isDropTarget ? Color.accentColor : Color.secondary.opacity(0.4),
                        style: StrokeStyle(lineWidth: 2, dash: [8])
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))

            if let imageURL {
                Text(imageURL.path())
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
