import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';

class NxMobileNavBarItem {
  const NxMobileNavBarItem({
    required this.icon,
    this.activeIcon,
    this.label,
  });

  final Widget icon;
  final Widget? activeIcon;
  final String? label;
}

/// Touch-optimized bottom navigation bar.
class NxMobileNavBar extends StatelessWidget {
  const NxMobileNavBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onChanged,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
  });

  final List<NxMobileNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onChanged;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final active = activeColor ?? NexoraColors.textPrimary;
    final inactive = inactiveColor ?? NexoraColors.textMuted;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? NexoraColors.surface,
        border: const Border(top: BorderSide(color: NexoraColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final selected = index == currentIndex;
            return Expanded(
              child: InkWell(
                onTap: onChanged == null ? null : () => onChanged!(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconTheme(
                        data: IconThemeData(
                          color: selected ? active : inactive,
                          size: 22,
                        ),
                        child: selected
                            ? (item.activeIcon ?? item.icon)
                            : item.icon,
                      ),
                      if (item.label != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          item.label!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selected ? active : inactive,
                            fontSize: 11,
                            fontWeight:
                                selected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

typedef NexoraMobileNavBar = NxMobileNavBar;