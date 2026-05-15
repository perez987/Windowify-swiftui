# CLAUDE.md

High-signal onboarding guide for agent sessions in this repository.

## 1) What this repo is

- macOS SwiftUI desktop app: **Windowify**
- Purpose: open an image and preview it in a configurable native macOS window.
- Stack: SwiftUI + AppKit interop (`NSWindow`, `NSOpenPanel`, `NSImage`).
- Localization: English and Spanish strings via `Languages/*/Localizable.strings`.

## 2) Session quick start

1. Read `README.md` for product behavior and attribute semantics.
2. Read `Windowify-swiftui/ViewModels/WindowifyViewModel.swift` first (core logic).
3. Read `Windowify-swiftui/Views/AttributeListView.swift` and `Views/ContentView.swift` (UI wiring).
4. Read `Windowify-swiftui/Models/WindowAttributes.swift` (source of truth for window flags).
5. Read `Windowify-swiftui/Languages/en.lproj/Localizable.strings` and `es.lproj/Localizable.strings` for user-facing copy changes.
6. Confirm whether change is UI-only, model-only, preview-window behavior, or localization-only.

## 3) Key constraints

- This project is intended to be built/run from **Xcode 15+ on macOS 13+**.
- In some agent environments, `xcodebuild` may be unavailable; validate by static review when necessary.
- Keep changes minimal and localized; preserve existing behavior unless task explicitly changes it.

## 4) File-level navigation

### App entry and lifecycle

- `Windowify-swiftui/App/WindowifyApp.swift`
  - App entry point (`@main`), dependency wiring, command registration.
- `Windowify-swiftui/App/AppDelegate.swift`
  - AppKit lifecycle behavior (quit when last window closes).
- `Windowify-swiftui/App/WindowifyCommands.swift`
  - App menu commands (currently includes File → Open…).

### Core behavior

- `Windowify-swiftui/ViewModels/WindowifyViewModel.swift`
  - Image loading/validation (`png`, `jpg`, `jpeg`).
  - Preview window creation/update (`NSWindow`, style masks, title/button visibility).
  - Minimal shortcut state snapshot/restore behavior.

### Data model

- `Windowify-swiftui/Models/WindowAttributes.swift`
  - Window attribute flags and `isMinimal` derived state.
  - `applyMinimalShortcut(_:)` default toggle behavior.

### UI

- `Windowify-swiftui/Views/ContentView.swift`
  - Main layout, drag-and-drop handling, root composition.
- `Windowify-swiftui/Views/AttributeListView.swift`
  - Title field, update button, toggles for all attributes.
- `Windowify-swiftui/Views/ImagePreviewPane.swift`
  - Image drop zone and preview/status presentation.

### Localization

- `Windowify-swiftui/Languages/en.lproj/Localizable.strings`
- `Windowify-swiftui/Languages/es.lproj/Localizable.strings`
  - Keep keys aligned between languages; update both files for user-facing copy changes.

### Project config and assets

- `Windowify-swiftui.xcodeproj/project.pbxproj`
  - Targets/build settings.
- `Windowify-swiftui/Info.plist`
  - App metadata/capabilities.
- `Windowify-swiftui/Assets.xcassets/` and `/Images`
  - App icon and README imagery.

## 5) Common change map

- Add or change a window attribute:
  1. Update `Models/WindowAttributes.swift`
  2. Wire behavior in `ViewModels/WindowifyViewModel.swift`
  3. Expose control in `Views/AttributeListView.swift`
  4. Update `README.md` if user-facing semantics changed

- Change image input behavior:
  - `WindowifyViewModel.loadImage(from:)`
  - Drag/drop path in `ContentView`
  - Open panel config in `WindowifyCommands`/`WindowifyViewModel.openImagePanel()`

- Change preview-window behavior:
  - `WindowifyViewModel.updatePreviewWindow()`
  - Keep style mask and button visibility updates consistent

- Change user-facing text / language behavior:
  - Update both `Languages/en.lproj/Localizable.strings` and `Languages/es.lproj/Localizable.strings`
  - Keep localization keys identical across locales
  - Verify impacted labels/buttons/headings in `Views/*`

## 6) Practical guardrails

- Keep UI labels and behavior aligned with README terminology.
- Keep English/Spanish localization keys synchronized; avoid locale-only key drift.
- Prefer small, surgical edits over broad refactors.
- When changing minimal mode logic, preserve snapshot/restore behavior.
- Avoid introducing dependencies; use existing SwiftUI/AppKit patterns.
