import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../theme/nexora_colors.dart';

/// Master top title bar shared by every Nexora desktop application.
///
/// Renders the dynamic application name (e.g. HARMONY, SUITE, PHOTOS) using
/// application subtitle on the left, plus the native window controls on the
/// right. The body of the bar is wrapped in a [DragToMoveArea] so the window
/// can be moved by dragging it.
class NexoraWindowHeader extends StatefulWidget {
  const NexoraWindowHeader({
    super.key,
    this.subtitle,
    this.appName,
    this.title,
    this.appTitle,
    this.applicationName,
    this.label,
    this.version,
    this.appVersion,
    this.versionLabel,
    this.buildVersion,
    this.height = 56,
    this.backgroundColor,
    this.showDivider = true,
    this.draggable = true,
    this.showWindowControls = true,
    this.onMinimize,
    this.onMaximize,
    this.onRestore,
    this.onClose,
    this.isMaximized,
    this.leading,
    this.trailing,
  });

  /// Dynamic subtitle of the current application (e.g. `SUITE`, `HARMONY`).
  final String? subtitle;
  final String? appName;
  final String? title;
  final String? appTitle;
  final String? applicationName;
  final String? label;

  /// Dynamic application version indicator (e.g. `v26.10.27+4`).
  final String? version;
  final String? appVersion;
  final String? versionLabel;
  final String? buildVersion;

  final double height;
  final Color? backgroundColor;
  final bool showDivider;
  final bool draggable;
  final bool showWindowControls;

  final VoidCallback? onMinimize;
  final VoidCallback? onMaximize;
  final VoidCallback? onRestore;
  final VoidCallback? onClose;

  /// Externally controlled maximized state. When `null` the widget tracks it
  /// internally through [windowManager].
  final bool? isMaximized;

  final Widget? leading;
  final Widget? trailing;

  String get resolvedSubtitle =>
      subtitle ??
      appName ??
      title ??
      appTitle ??
      applicationName ??
      label ??
      'SUITE';

  String? get resolvedVersion =>
      version ?? appVersion ?? versionLabel ?? buildVersion;

  @override
  State<NexoraWindowHeader> createState() => _NexoraWindowHeaderState();
}

class _NexoraWindowHeaderState extends State<NexoraWindowHeader>
    with WindowListener {
  bool _maximized = false;

  @override
  void initState() {
    super.initState();
    _maximized = widget.isMaximized ?? false;
    if (widget.isMaximized == null) {
      _syncMaximized();
    }
    try {
      windowManager.addListener(this);
    } catch (_) {}
  }

  @override
  void didUpdateWidget(covariant NexoraWindowHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMaximized != null) {
      _maximized = widget.isMaximized!;
    }
  }

  @override
  void dispose() {
    try {
      windowManager.removeListener(this);
    } catch (_) {}
    super.dispose();
  }

  Future<void> _syncMaximized() async {
    try {
      final value = await windowManager.isMaximized();
      if (mounted) setState(() => _maximized = value);
    } catch (_) {}
  }

  @override
  void onWindowMaximize() {
    if (mounted) setState(() => _maximized = true);
  }

  @override
  void onWindowUnmaximize() {
    if (mounted) setState(() => _maximized = false);
  }

  @override
  void onWindowRestore() {
    _syncMaximized();
  }

  Future<void> _handleMinimize() async {
    if (widget.onMinimize != null) {
      widget.onMinimize!();
      return;
    }
    try {
      await windowManager.minimize();
    } catch (_) {}
  }

  Future<void> _handleToggleMaximize() async {
    if (widget.onMaximize != null || widget.onRestore != null) {
      if (_maximized && widget.onRestore != null) {
        widget.onRestore!();
      } else if (!_maximized && widget.onMaximize != null) {
        widget.onMaximize!();
      } else {
        (widget.onMaximize ?? widget.onRestore)?.call();
      }
      if (widget.isMaximized == null) {
        setState(() => _maximized = !_maximized);
      }
      return;
    }
    try {
      if (await windowManager.isMaximized()) {
        await windowManager.unmaximize();
        if (mounted) setState(() => _maximized = false);
      } else {
        await windowManager.maximize();
        if (mounted) setState(() => _maximized = true);
      }
    } catch (_) {}
  }

  Future<void> _handleClose() async {
    if (widget.onClose != null) {
      widget.onClose!();
      return;
    }
    try {
      await windowManager.close();
    } catch (_) {}
  }

  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (widget.leading != null) ...[
            widget.leading!,
            const SizedBox(width: 10),
          ],
          Text(
            widget.resolvedSubtitle.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Gliker',
              fontWeight: FontWeight.w700,
              fontSize: 22,
              letterSpacing: 1.2,
              color: NexoraColors.foreground,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 1,
            height: widget.height,
            color: NexoraColors.border,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final background = widget.backgroundColor ?? NexoraColors.surface;

    final left = widget.draggable
        ? DragToMoveArea(child: _buildCaption())
        : _buildCaption();

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: background,
        border: widget.showDivider
            ? const Border(bottom: BorderSide(color: NexoraColors.border))
            : null,
      ),
      child: Row(
        children: [
          Expanded(child: left),
          if (widget.trailing != null) widget.trailing!,
          Container(
            width: 1,
            height: widget.height,
            color: NexoraColors.border,
          ),
          const SizedBox(width: 6),
          if (widget.showWindowControls) ...[
            WindowCaptionButton.minimize(
              brightness: Brightness.dark,
              onPressed: _handleMinimize,
            ),
            if (_maximized)
              WindowCaptionButton.unmaximize(
                brightness: Brightness.dark,
                onPressed: _handleToggleMaximize,
              )
            else
              WindowCaptionButton.maximize(
                brightness: Brightness.dark,
                onPressed: _handleToggleMaximize,
              ),
            WindowCaptionButton.close(
              brightness: Brightness.dark,
              onPressed: _handleClose,
            ),
          ],
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}

/// Convenience scaffold that places a [NexoraWindowHeader] at the top of the
/// window body.
class NexoraScaffold extends StatelessWidget {
  const NexoraScaffold({
    super.key,
    required this.body,
    this.subtitle,
    this.appName,
    this.title,
    this.appTitle,
    this.applicationName,
    this.label,
    this.version,
    this.appVersion,
    this.versionLabel,
    this.buildVersion,
    this.headerHeight = 56,
    this.backgroundColor,
    this.draggable = true,
    this.showWindowControls = true,
    this.onMinimize,
    this.onMaximize,
    this.onRestore,
    this.onClose,
    this.isMaximized,
    this.trailing,
  });

  final Widget body;
  final String? subtitle;
  final String? appName;
  final String? title;
  final String? appTitle;
  final String? applicationName;
  final String? label;

  /// Dynamic application version indicator (e.g. `v26.10.27+4`).
  final String? version;
  final String? appVersion;
  final String? versionLabel;
  final String? buildVersion;
  final double headerHeight;
  final Color? backgroundColor;
  final bool draggable;
  final bool showWindowControls;
  final VoidCallback? onMinimize;
  final VoidCallback? onMaximize;
  final VoidCallback? onRestore;
  final VoidCallback? onClose;
  final bool? isMaximized;
  final Widget? trailing;

  String get _subtitle =>
      subtitle ??
      appName ??
      title ??
      appTitle ??
      applicationName ??
      label ??
      'SUITE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NexoraColors.background,
      body: Column(
        children: [
          NexoraWindowHeader(
            subtitle: _subtitle,
            version: version,
            appVersion: appVersion,
            versionLabel: versionLabel,
            buildVersion: buildVersion,
            height: headerHeight,
            backgroundColor: backgroundColor,
            draggable: draggable,
            showWindowControls: showWindowControls,
            onMinimize: onMinimize,
            onMaximize: onMaximize,
            onRestore: onRestore,
            onClose: onClose,
            isMaximized: isMaximized,
            trailing: trailing,
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}

/// Backwards-compatible alias for the legacy Suite title bar.
typedef NexoraTitleBar = NexoraWindowHeader;
