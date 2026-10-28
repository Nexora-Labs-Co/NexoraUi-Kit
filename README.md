# NexoraUi-Kit

Shared Flutter UI kit for the Nexora suite. Provides the standard window chrome and
common bars used across Nexora Suite, Harmony and the rest of the ecosystem.

## Components

### `NexoraWindowHeader`
Master top title bar. Shows the current application name (e.g. `HARMONY`,
`SUITE`, `PHOTOS`) in the *Gliker* typeface, framed by full-height vertical
dividers, plus the native window controls (minimize, maximize/restore, close).
The body is wrapped in a `DragToMoveArea` so the window can be moved by dragging.

```dart
const NexoraWindowHeader(subtitle: 'HARMONY')
```

### `NexoraActionBar`
Horizontal action bar split into three independent sections (`left`, `center`,
`right`) with the standard monochrome styling.

```dart
NexoraActionBar(
  left: ...,
  center: ...,
  right: ...,
)
```

### `NexoraFooterBar`
Compact footer bar with a thin top divider and independently configurable left
and right content.

```dart
NexoraFooterBar(
  left: Text('v26.10.27+1'),
  right: Row(...),
)
```

### `NexoraColors` / `NexoraTheme`
Strictly monochrome palette and dark theme shared by every Nexora application.

## Usage

Add the dependency:

```yaml
dependencies:
  nexora_ui_kit:
    path: ../NexoraUi-Kit
```

Import:

```dart
import 'package:nexora_ui_kit/nexora_ui_kit.dart';
```

## Notes

- Windowed desktop apps should hide the native title bar via `window_manager`
  (`TitleBarStyle.hidden`) and set a transparent background so the rounded
  corners render cleanly.
