import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';
import '../tokens/nexora_typography.dart';

/// Compact horizontal quick-access card with a rounded thumbnail and bold title.
class NxQuickAccessCard extends StatelessWidget {
  const NxQuickAccessCard({
    super.key,
    this.title,
    this.text,
    this.label,
    this.thumbnail,
    this.image,
    this.cover,
    this.onTap,
    this.height = 56,
    this.width,
    this.backgroundColor,
    this.borderRadius = 8,
    this.titleStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  });

  final Object? title;
  final Object? text;
  final Object? label;
  final Widget? thumbnail;
  final ImageProvider? image;
  final Widget? cover;
  final VoidCallback? onTap;
  final double height;
  final double? width;
  final Color? backgroundColor;
  final double borderRadius;
  final TextStyle? titleStyle;
  final EdgeInsets padding;

  Object? get _title => title ?? text ?? label;

  Widget _thumbnail() {
    if (thumbnail != null) return thumbnail!;
    if (cover != null) return cover!;
    if (image != null) {
      return Image(image: image!, fit: BoxFit.cover);
    }
    return Container(color: NexoraColors.surfaceHover);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? NexoraColors.surfaceAlt,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius > 4 ? borderRadius - 2 : borderRadius),
                  child: SizedBox(
                    width: height - (padding.vertical),
                    height: height - (padding.vertical),
                    child: _thumbnail(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    (_title ?? '').toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle ??
                        NexoraTypography.titleMedium.copyWith(
                          color: NexoraColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef NexoraQuickAccessCard = NxQuickAccessCard;