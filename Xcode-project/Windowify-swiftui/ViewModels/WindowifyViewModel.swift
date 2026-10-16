import AppKit
import Combine
import UniformTypeIdentifiers

private final class PreviewWindow: NSWindow {
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        let modifiers = event.modifierFlags.intersection(.deviceIndependentFlagsMask)

        if modifiers == [.command], event.charactersIgnoringModifiers?.lowercased() == "w" {
            close()
            return true
        }

        return super.performKeyEquivalent(with: event)
    }
}

@MainActor
final class WindowifyViewModel: ObservableObject {
    @Published var image: NSImage? {
        didSet { updatePreviewWindow() }
    }

    @Published var imageURL: URL?
    @Published var title = ""
    @Published var selectedMode: WindowMode = .default {
        didSet { attributes = WindowAttributes.from(mode: selectedMode) }
    }

    private(set) var attributes = WindowAttributes()

    private var previewWindow: NSWindow?
    private var previewImageView: NSImageView?

    func openImagePanel() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedContentTypes = [.png, .jpeg]

        guard panel.runModal() == .OK, let url = panel.url else { return }
        loadImage(from: url)
    }

    func loadImage(from url: URL) {
        let extensionName = url.pathExtension.lowercased()
        guard ["png", "jpg", "jpeg"].contains(extensionName) else {
            return
        }

        guard
            let image = NSImage(contentsOf: url),
            image.size.width > 0,
            image.size.height > 0
        else {
            return
        }

        imageURL = url
        self.image = image
    }

    var canRefreshPreview: Bool {
        image != nil
    }

    private func styleMask() -> NSWindow.StyleMask {
        var style: NSWindow.StyleMask = [.titled]
        if attributes.closable { style.insert(.closable) }
        if attributes.miniaturizable { style.insert(.miniaturizable) }
        if attributes.resizable { style.insert(.resizable) }
        if attributes.fullSizeContentView { style.insert(.fullSizeContentView) }
        return style
    }

    func updatePreviewWindow() {
        guard let image else {
            previewWindow?.orderOut(nil)
            return
        }

        if previewWindow == nil {
            let imageView = NSImageView(frame: NSRect(origin: .zero, size: image.size))
            imageView.imageScaling = .scaleAxesIndependently

            previewWindow = PreviewWindow(
                contentRect: NSRect(origin: .zero, size: image.size),
                styleMask: styleMask(),
                backing: .buffered,
                defer: false
            )
            previewWindow?.isReleasedWhenClosed = false
            previewWindow?.contentView = imageView
            previewWindow?.center()
            previewImageView = imageView
        }

        guard let previewWindow else { return }

        previewWindow.styleMask = styleMask()
        previewWindow.title = title
        previewImageView?.frame = NSRect(origin: .zero, size: image.size)
        previewImageView?.image = image
        previewWindow.setContentSize(image.size)
        previewWindow.standardWindowButton(.closeButton)?.isHidden = attributes.closeButtonHidden
        previewWindow.standardWindowButton(.miniaturizeButton)?.isHidden =
            attributes.miniaturizeButtonHidden
        previewWindow.standardWindowButton(.zoomButton)?.isHidden = attributes.zoomButtonHidden
        previewWindow.titlebarAppearsTransparent = attributes.titlebarAppearsTransparent
        previewWindow.makeKeyAndOrderFront(nil)
    }
}
