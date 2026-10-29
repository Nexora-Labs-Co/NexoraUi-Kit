# AGENTS.md

Flutter/Dart package (`nexora_ui_kit`) — shared UI kit for Nexora desktop apps. Not an app; no `main()`.

## Commands

```bash
flutter pub get          # install
flutter analyze          # static analysis
flutter test            # all tests
flutter test test/window_header_test.dart
flutter test --name "renders application name in uppercase"
```

Contributing order: `flutter analyze` then `flutter test`. No separate typecheck/codegen step.

## Entry points / ownership

- Canonical barrel: `lib/nexora_ui_kit.dart` (exports `src/...`).
- Real implementations live in `lib/src/{theme,widgets}/`. Top-level `lib/*.dart`, `lib/theme/`, and `lib/widgets/` are re-export shims — edit `src/`, not the shims.
- Public API: `NexoraColors`, `NexoraTheme`, `NexoraWindowHeader`, `NexoraScaffold` (also `NexoraTitleBar` alias), `NexoraActionBar`, `NexoraFooterBar`, `NexoraSidebar`, `NexoraSidebarLayout`.

## Dependencies / toolchain

- Runtime: `flutter` (sdk) + `window_manager: ^0.5.2`.
- Dev: `flutter_test`, `flutter_lints: ^6.0.0`. There is no `analysis_options.yaml`; lint defaults apply.
- SDK constraints: Dart `^3.13.7`, Flutter `>=3.24.0`.
- Assets: `assets/fonts/` (Gliker family) registered in `pubspec.yaml` under `flutter:`.

## Gotchas

- README's `font_awesome_flutter` claim is stale — it is not a dependency.
- `window_manager` calls are wrapped in `try/catch` so widget tests run headless; keep those guards.
- `NexoraWindowHeader` uses `WindowCaptionButton`/`DragToMoveArea` from `window_manager`.
- Versioning is date-based (`26.10.28+1` in `pubspec.yaml`); use Conventional Commits and branch names `feat/`, `fix/`, `docs/`, `refactor/`.
- No CI configured yet (roadmap item); verify locally with analyze + test.