import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';
import '../tokens/nexora_typography.dart';

/// Compact header optimized for mobile viewports.
class NxMobileHeader extends StatelessWidget {
  const NxMobileHeader({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.height = 56,
  });

  final Object? title;
  final Object? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? NexoraColors.surface,
        border: const Border(bottom: BorderSide(color: NexoraColors.border)),
      ),
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 12)],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: NexoraTypography.titleMedium,
                  ),
                if (subtitle != null)
                  Text(
                    subtitle.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: NexoraTypography.bodySmall,
                  ),
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 12), trailing!],
        ],
      ),
    );
  }
}

typedef NexoraMobileHeader = NxMobileHeader;