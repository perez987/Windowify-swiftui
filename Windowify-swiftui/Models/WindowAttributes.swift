enum WindowMode: CaseIterable, Identifiable {
    case `default`
    case noTitlebar
    case transparentTitlebar

    var id: Self { self }

    var labelKey: String {
        switch self {
        case .default: return "Default options with titlebar"
        case .noTitlebar: return "Extended image with no titlebar"
        case .transparentTitlebar: return "Extended image with transparent titlebar"
        }
    }
}

struct WindowAttributes {
    var closable = true
    var miniaturizable = true
    var resizable = true
    var closeButtonHidden = false
    var miniaturizeButtonHidden = false
    var zoomButtonHidden = false

    var fullSizeContentView = false
    var titlebarAppearsTransparent = false

    static func from(mode: WindowMode) -> WindowAttributes {
        var attrs = WindowAttributes()
        switch mode {
        case .default:
            break
        case .noTitlebar:
            attrs.closable = false
            attrs.miniaturizable = false
            attrs.resizable = false
            attrs.titlebarAppearsTransparent = true
            attrs.fullSizeContentView = true
        case .transparentTitlebar:
            attrs.titlebarAppearsTransparent = true
            attrs.fullSizeContentView = true
        }
        return attrs
    }
}
