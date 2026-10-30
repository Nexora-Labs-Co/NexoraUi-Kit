import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';
import '../tokens/nexora_typography.dart';

/// Standardized square media card with hover feedback.
class NxMediaCard extends StatefulWidget {
  const NxMediaCard({
    super.key,
    this.title,
    this.text,
    this.subtitle,
    this.description,
    this.cover,
    this.image,
    this.thumbnail,
    this.onTap,
    this.onPlay,
    this.size = 160,
    this.borderRadius = 8,
    this.backgroundColor,
    this.hoverColor,
    this.titleStyle,
    this.subtitleStyle,
    this.showPlayButton = false,
  });

  final Object? title;
  final Object? text;
  final Object? subtitle;
  final Object? description;
  final Widget? cover;
  final ImageProvider? image;
  final Widget? thumbnail;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;
  final double size;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? hoverColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool showPlayButton;

  @override
  State<NxMediaCard> createState() => _NxMediaCardState();
}

class _NxMediaCardState extends State<NxMediaCard> {
  bool _hovered = false;

  Widget _cover() {
    if (widget.cover != null) return widget.cover!;
    if (widget.thumbnail != null) return widget.thumbnail!;
    if (widget.image != null) {
      return Image(image: widget.image!, fit: BoxFit.cover);
    }
    return Container(color: NexoraColors.surfaceAlt);
  }

  @override
  Widget build(BuildContext context) {
    final title = (widget.title ?? widget.text ?? '').toString();
    final subtitle = (widget.subtitle ?? widget.description ?? '').toString();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: widget.size,
          decoration: BoxDecoration(
            color: _hovered
                ? (widget.hoverColor ?? NexoraColors.surfaceHover)
                : (widget.backgroundColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _cover(),
                      if (widget.showPlayButton || _hovered)
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 160),
                            opacity: _hovered ? 1 : 0,
                            child: GestureDetector(
                              onTap: widget.onPlay,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: NexoraColors.textPrimary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: NexoraColors.background,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: widget.titleStyle ?? NexoraTypography.titleMedium,
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: widget.subtitleStyle ??
                      NexoraTypography.bodySmall.copyWith(
                        color: NexoraColors.textMuted,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

typedef NexoraMediaCard = NxMediaCard;