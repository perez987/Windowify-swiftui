# CLI → SwiftUI migration (current status)

Windowify has been migrated from a command-line tool to a macOS SwiftUI app (Swift 5, Xcode 15+, macOS 13+).  
This document reflects the current implementation.

## App architecture

- SwiftUI `@main` app entry point (`WindowifyApp`).
- AppKit delegate integration (`AppDelegate`) keeps desktop-style behavior (`applicationShouldTerminateAfterLastWindowClosed = true`).
- `WindowifyViewModel` owns image loading, title state, attribute state, and preview window updates.

## Main UI and image input

- Main window uses an `HSplitView` with:
  - `AttributeListView` (title + toggles + update button).
  - `ImagePreviewPane` (drop zone + image/path display).
- Image input supports:
  - Drag and drop (`.dropDestination(for: URL.self)`).
  - File menu **Open…** with `⌘O` (`WindowifyCommands`).
- Input is restricted to `png/jpg/jpeg`:
  - `NSOpenPanel.allowedContentTypes = [.png, .jpeg]`
  - Runtime extension validation in `loadImage(from:)`.

## Attribute controls

- Toggle controls are available for:
  - `closable`
  - `miniaturizable`
  - `resizable`
  - `titlebarAppearsTransparent`
  - `closeButtonHidden`
  - `miniaturizeButtonHidden`
  - `zoomButtonHidden`
- `--minimal` is exposed as a UI toggle:
  - Enabling gets a snapshot of selected attributes and applies minimal settings.
  - Disabling restores the previous snapshot when available.

## Preview window behavior

- Preview uses native `NSWindow` + `NSImageView`.
- Image changes trigger automatic preview refresh.
- Title/attribute edits are applied with **Update Preview**.
- Updates include:
  - style mask recalculation
  - title and title visibility updates
  - standard window button visibility
  - content size/image refresh while reusing the same preview image view.

## Commands / menus

- New-item command group is replaced (no default “New” command).
- File menu contains **Open…** (`⌘O`).
- Help command group is currently replaced with an empty group (no custom Help window in the current code).

## Documentation

- `README.md` documents the SwiftUI GUI workflow (drag/drop, `⌘O`, title field, toggles, update preview).
