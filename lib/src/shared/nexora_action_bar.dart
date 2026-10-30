import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';

/// Horizontal action bar with three independent sections (left, center, right).
class NexoraActionBar extends StatelessWidget {
  const NexoraActionBar({
    super.key,
    this.left,
    this.leading,
    this.leftWidget,
    this.center,
    this.middle,
    this.centerWidget,
    this.right,
    this.trailing,
    this.rightWidget,
    this.height,
    this.backgroundColor,
    this.showDivider = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.borderRadius = 8,
  });

  final Widget? left;
  final Widget? leading;
  final Widget? leftWidget;

  final Widget? center;
  final Widget? middle;
  final Widget? centerWidget;

  final Widget? right;
  final Widget? trailing;
  final Widget? rightWidget;

  final double? height;
  final Color? backgroundColor;
  final bool showDivider;
  final EdgeInsets padding;
  final double borderRadius;

  Widget? get _left => left ?? leading ?? leftWidget;
  Widget? get _center => center ?? middle ?? centerWidget;
  Widget? get _right => right ?? trailing ?? rightWidget;

  @override
  Widget build(BuildContext context) {
    final background = backgroundColor ?? NexoraColors.surface;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        border: showDivider
            ? const Border(bottom: BorderSide(color: NexoraColors.border))
            : null,
      ),
      child: Row(
        children: [
          if (_left != null) _left!,
          if (_center != null) ...[
            const SizedBox(width: 12),
            Expanded(child: _center!),
            const SizedBox(width: 12),
          ] else
            const Spacer(),
          if (_right != null) _right!,
        ],
      ),
    );
  }
}
