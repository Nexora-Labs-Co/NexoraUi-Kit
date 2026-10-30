import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';

/// Reusable, generic sidebar container for Nexora desktop layouts.
///
/// This widget intentionally contains no domain-specific logic. It provides a
/// fixed-width (or collapsed) region with Nexora dark-theme styling, an optional
/// scrollable content area and a right-hand border.
class NexoraSidebar extends StatefulWidget {
  const NexoraSidebar({
    super.key,
    double? width,
    double? sidebarWidth,
    double? expandedWidth,
    this.collapsedWidth = 0,
    bool? collapsed,
    bool? isCollapsed,
    this.initiallyCollapsed = false,
    this.collapsible = true,
    bool? scrollable,
    bool? isScrollable,
    Color? backgroundColor,
    Color? background,
    Color? color,
    this.borderColor,
    bool? showBorder,
    bool? showDivider,
    Widget? child,
    Widget? content,
    Widget? body,
    this.padding = const EdgeInsets.all(16),
    VoidCallback? onCollapsedChanged,
    VoidCallback? onToggle,
    this.showToggle = false,
  })  : width = width ?? sidebarWidth ?? expandedWidth ?? 240,
        collapsed = collapsed ?? isCollapsed,
        scrollable = scrollable ?? isScrollable ?? true,
        backgroundColor = backgroundColor ?? background ?? color,
        showBorder = showBorder ?? showDivider ?? true,
        child = child ?? content ?? body,
        onCollapsedChanged = onCollapsedChanged ?? onToggle;

  /// Width of the sidebar when expanded.
  final double width;

  /// Width of the sidebar when collapsed.
  final double collapsedWidth;

  /// Controlled collapsed state. When `null`, the widget manages its own state.
  final bool? collapsed;

  /// Initial collapsed state for uncontrolled usage.
  final bool initiallyCollapsed;

  /// Whether the sidebar can be collapsed.
  final bool collapsible;

  /// Whether the content area scrolls.
  final bool scrollable;

  /// Background color. Defaults to [NexoraColors.surfaceAlt].
  final Color? backgroundColor;

  /// Border color. Defaults to [NexoraColors.border].
  final Color? borderColor;

  /// Whether to render the right-hand border.
  final bool showBorder;

  /// Sidebar content.
  final Widget? child;

  /// Content padding.
  final EdgeInsets padding;

  /// Called when the collapsed state changes.
  final VoidCallback? onCollapsedChanged;

  /// Whether to render a built-in collapse toggle.
  final bool showToggle;

  @override
  State<NexoraSidebar> createState() => _NexoraSidebarState();
}

class _NexoraSidebarState extends State<NexoraSidebar> {
  late bool _collapsed = widget.collapsed ?? widget.initiallyCollapsed;

  @override
  void didUpdateWidget(covariant NexoraSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.collapsed != null) {
      _collapsed = widget.collapsed!;
    }
  }

  bool get _isCollapsed => widget.collapsed ?? _collapsed;

  void _toggle() {
    final next = !_isCollapsed;
    if (widget.collapsed == null) {
      setState(() => _collapsed = next);
    }
    widget.onCollapsedChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final collapsed = _isCollapsed;
    final effectiveWidth =
        collapsed ? widget.collapsedWidth : widget.width;
    final background = widget.backgroundColor ?? NexoraColors.surfaceAlt;

    final showContent = !(collapsed && widget.collapsedWidth < 40);

    Widget? content;
    if (showContent && widget.child != null) {
      content = widget.scrollable
          ? SingleChildScrollView(
              padding: widget.padding,
              child: widget.child,
            )
          : Padding(
              padding: widget.padding,
              child: widget.child,
            );
    }

    return Container(
      width: effectiveWidth,
      decoration: BoxDecoration(
        color: background,
        border: widget.showBorder
            ? Border(
                right: BorderSide(
                  color: widget.borderColor ?? NexoraColors.border,
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.collapsible && widget.showToggle)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  collapsed ? Icons.chevron_right : Icons.chevron_left,
                  color: NexoraColors.foreground,
                ),
                onPressed: _toggle,
              ),
            ),
          if (content != null) Expanded(child: content),
        ],
      ),
    );
  }
}

/// Simple two-region layout (sidebar + body) without a window header.
class NexoraSidebarLayout extends StatelessWidget {
  const NexoraSidebarLayout({
    super.key,
    this.sidebar,
    this.sidebarWidth,
    this.sidebarBackgroundColor,
    this.sidebarCollapsed,
    this.sidebarScrollable = true,
    this.showSidebarBorder = true,
    this.sidebarCollapsedWidth = 0,
    this.body,
    this.child,
    this.backgroundColor,
  });

  final Widget? sidebar;
  final double? sidebarWidth;
  final Color? sidebarBackgroundColor;
  final bool? sidebarCollapsed;
  final bool sidebarScrollable;
  final bool showSidebarBorder;
  final double sidebarCollapsedWidth;
  final Widget? body;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final resolvedSidebar = sidebar is NexoraSidebar
        ? sidebar!
        : NexoraSidebar(
            width: sidebarWidth ?? 240,
            collapsedWidth: sidebarCollapsedWidth,
            collapsed: sidebarCollapsed,
            scrollable: sidebarScrollable,
            showBorder: showSidebarBorder,
            backgroundColor: sidebarBackgroundColor,
            child: sidebar,
          );

    return Container(
      color: backgroundColor ?? NexoraColors.background,
      child: Row(
        children: [
          resolvedSidebar,
          Expanded(child: body ?? child ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}