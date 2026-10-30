import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';

/// Compact monochrome footer bar shared across the Nexora suite.
///
/// The left and right sides can be configured independently through any of the
/// accepted aliases ([left]/[leading]/[leftWidget] and
/// [right]/[trailing]/[rightWidget]).
class NexoraFooterBar extends StatelessWidget {
  const NexoraFooterBar({
    super.key,
    this.left,
    this.leading,
    this.leftWidget,
    this.right,
    this.trailing,
    this.rightWidget,
    this.height = 34,
    this.backgroundColor,
    this.showDivider = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  final Widget? left;
  final Widget? leading;
  final Widget? leftWidget;

  final Widget? right;
  final Widget? trailing;
  final Widget? rightWidget;

  final double height;
  final Color? backgroundColor;
  final bool showDivider;
  final EdgeInsets padding;

  Widget? get _left => left ?? leading ?? leftWidget;
  Widget? get _right => right ?? trailing ?? rightWidget;

  @override
  Widget build(BuildContext context) {
    final background = backgroundColor ?? NexoraColors.surface;

    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        border: showDivider
            ? const Border(top: BorderSide(color: NexoraColors.border))
            : null,
      ),
      child: Row(
        children: [
          if (_left != null) _left!,
          const Spacer(),
          if (_right != null) _right!,
        ],
      ),
    );
  }
}
