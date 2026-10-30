import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';

/// Reusable top navigation bar with back/refresh and settings/profile slots.
class NxTopNavigationBar extends StatelessWidget {
  const NxTopNavigationBar({
    super.key,
    this.onBack,
    this.onRefresh,
    this.onSettings,
    this.onProfile,
    this.height = 56,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.backgroundColor,
    this.showBack = true,
    this.showRefresh = true,
    this.showSettings = true,
    this.showProfile = true,
    this.leading,
    this.trailing,
    this.title,
  });

  final VoidCallback? onBack;
  final VoidCallback? onRefresh;
  final VoidCallback? onSettings;
  final VoidCallback? onProfile;
  final double height;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final bool showBack;
  final bool showRefresh;
  final bool showSettings;
  final bool showProfile;
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? NexoraColors.surface,
        border: const Border(
          bottom: BorderSide(color: NexoraColors.border),
        ),
      ),
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 8)],
          if (showBack)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack,
              tooltip: 'Back',
            ),
          if (showRefresh)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: onRefresh,
              tooltip: 'Refresh',
            ),
          if (title != null) ...[
            const SizedBox(width: 8),
            Expanded(child: title!),
          ] else
            const Spacer(),
          if (trailing != null) ...[trailing!, const SizedBox(width: 8)],
          if (showSettings)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: onSettings,
              tooltip: 'Settings',
            ),
          if (showProfile)
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: onProfile,
              tooltip: 'Profile',
            ),
        ],
      ),
    );
  }
}

typedef NexoraTopNavigationBar = NxTopNavigationBar;