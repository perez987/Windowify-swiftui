struct WindowAttributes {
    var closable = true
    var miniaturizable = true
    var resizable = true
    var closeButtonHidden = false
    var miniaturizeButtonHidden = false
    var zoomButtonHidden = false

    var fullSizeContentView = false
    var titlebarAppearsTransparent = false

    var isMinimal: Bool {
        !closable && !miniaturizable && !resizable
    }

    mutating func applyMinimalShortcut(_ isEnabled: Bool) {
        if isEnabled {
            closable = false
            miniaturizable = false
            resizable = false
            fullSizeContentView = true
            titlebarAppearsTransparent = true
        } else {
            closable = true
            miniaturizable = true
            resizable = true
            fullSizeContentView = false
            titlebarAppearsTransparent = false
        }
    }
}
