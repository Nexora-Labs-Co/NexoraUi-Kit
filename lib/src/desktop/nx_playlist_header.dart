import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';
import '../tokens/nexora_typography.dart';

/// Unified playlist / library header with three zones:
/// top actions, massive centered title, and bottom metadata.
class NxPlaylistHeader extends StatelessWidget {
  const NxPlaylistHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.metadata,
    this.bottomMetadata,
    this.cover,
    this.coverImage,
    this.image,
    this.height = 320,
    this.backgroundColor,
    this.borderRadius = 0,
    this.onPlay,
    this.onShuffle,
    this.onDownload,
    this.onAddCollaborator,
    this.onMultiAdd,
    this.onSearch,
    this.titleStyle,
    this.metadataStyle,
    this.showActions = true,
    this.topActions,
    this.gradient = true,
  });

  final Object? title;
  final Widget? titleWidget;
  final Object? subtitle;
  final Object? metadata;
  final Object? bottomMetadata;
  final Widget? cover;
  final ImageProvider? coverImage;
  final ImageProvider? image;
  final double height;
  final Color? backgroundColor;
  final double borderRadius;
  final VoidCallback? onPlay;
  final VoidCallback? onShuffle;
  final VoidCallback? onDownload;
  final VoidCallback? onAddCollaborator;
  final VoidCallback? onMultiAdd;
  final VoidCallback? onSearch;
  final TextStyle? titleStyle;
  final TextStyle? metadataStyle;
  final bool showActions;
  final List<Widget>? topActions;
  final bool gradient;

  ImageProvider? get _image => coverImage ?? image;

  Widget _asWidget(Object? value, TextStyle? style) {
    if (value == null) return const SizedBox.shrink();
    if (value is Widget) return value;
    return Text(value.toString(), style: style);
  }

  @override
  Widget build(BuildContext context) {
    final titleContent = titleWidget ??
        (title == null
            ? const SizedBox.shrink()
            : (title is Widget
                ? title as Widget
                : FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      title.toString(),
                      maxLines: 1,
                      style: titleStyle ?? NexoraTypography.displayMedium,
                    ),
                  )));

    final metadataContent = _asWidget(
      bottomMetadata ?? metadata ?? subtitle,
      metadataStyle ?? NexoraTypography.bodyMedium,
    );

    final actions = topActions ??
        <Widget>[
          IconButton(
            onPressed: onPlay,
            icon: const Icon(Icons.play_arrow),
            color: NexoraColors.textPrimary,
            tooltip: 'Play',
          ),
          IconButton(
            onPressed: onShuffle,
            icon: const Icon(Icons.shuffle),
            color: NexoraColors.textPrimary,
            tooltip: 'Shuffle',
          ),
          IconButton(
            onPressed: onDownload,
            icon: const Icon(Icons.download),
            color: NexoraColors.textPrimary,
            tooltip: 'Download',
          ),
          IconButton(
            onPressed: onAddCollaborator,
            icon: const Icon(Icons.person_add_alt_1),
            color: NexoraColors.textMuted,
            tooltip: 'Add collaborator',
          ),
          IconButton(
            onPressed: onMultiAdd,
            icon: const Icon(Icons.playlist_add),
            color: NexoraColors.textMuted,
            tooltip: 'Multi-add',
          ),
          IconButton(
            onPressed: onSearch,
            icon: const Icon(Icons.search),
            color: NexoraColors.textMuted,
            tooltip: 'Search',
          ),
        ];

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? NexoraColors.surfaceDark,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (cover != null) cover!,
          if (cover == null && _image != null)
            Image(image: _image!, fit: BoxFit.cover),
          if (gradient)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x66000000), Color(0xCC000000)],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showActions)
                  Row(
                    children: [
                      ...actions,
                      const Spacer(),
                    ],
                  ),
                Expanded(
                  child: Center(child: titleContent),
                ),
                metadataContent,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef NexoraPlaylistHeader = NxPlaylistHeader;