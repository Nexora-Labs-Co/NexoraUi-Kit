import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';

/// Collapsible bottom sheet for mobile player controls.
class NxCollapsiblePlayerSheet extends StatefulWidget {
  const NxCollapsiblePlayerSheet({
    super.key,
    this.collapsedHeight = 72,
    this.expandedHeight = 420,
    this.backgroundColor,
    required this.collapsedBuilder,
    required this.expandedBuilder,
  });

  final double collapsedHeight;
  final double expandedHeight;
  final Color? backgroundColor;
  final WidgetBuilder collapsedBuilder;
  final WidgetBuilder expandedBuilder;

  @override
  State<NxCollapsiblePlayerSheet> createState() =>
      _NxCollapsiblePlayerSheetState();
}

class _NxCollapsiblePlayerSheetState extends State<NxCollapsiblePlayerSheet> {
  bool _expanded = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    final height = _expanded ? widget.expandedHeight : widget.collapsedHeight;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      height: height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? NexoraColors.surfaceAlt,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: const Border(top: BorderSide(color: NexoraColors.border)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggle,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: NexoraColors.borderStrong,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          Expanded(
            child: _expanded
                ? widget.expandedBuilder(context)
                : widget.collapsedBuilder(context),
          ),
        ],
      ),
    );
  }
}

typedef NexoraCollapsiblePlayerSheet = NxCollapsiblePlayerSheet;