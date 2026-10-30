import 'package:flutter/material.dart';

import '../tokens/nexora_colors.dart';
import '../tokens/nexora_typography.dart';

enum NxButtonVariant { primary, secondary, outline, ghost }

/// Standardized Nexora button.
class NxButton extends StatelessWidget {
  const NxButton({
    super.key,
    this.label,
    this.text,
    this.title,
    this.child,
    this.onPressed,
    this.icon,
    this.variant = NxButtonVariant.primary,
    this.size = NxButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 8,
    this.fullWidth = false,
  });

  final Object? label;
  final Object? text;
  final Object? title;
  final Widget? child;
  final VoidCallback? onPressed;
  final IconData? icon;
  final NxButtonVariant variant;
  final NxButtonSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final bool fullWidth;

  Object? get _label => label ?? text ?? title;

  EdgeInsets get _padding {
    switch (size) {
      case NxButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case NxButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case NxButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
    }
  }

  double get _fontSize {
    switch (size) {
      case NxButtonSize.small:
        return 12;
      case NxButtonSize.medium:
        return 13;
      case NxButtonSize.large:
        return 15;
    }
  }

  @override
  Widget build(BuildContext context) {
    final contentChild = child ??
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: _fontSize + 2),
              const SizedBox(width: 8),
            ],
            Text(
              (_label ?? '').toString(),
              style: NexoraTypography.labelLarge.copyWith(fontSize: _fontSize),
            ),
          ],
        );

    final fg = foregroundColor ??
        (variant == NxButtonVariant.primary
            ? NexoraColors.background
            : NexoraColors.textPrimary);
    final bg = backgroundColor ??
        (variant == NxButtonVariant.primary
            ? NexoraColors.textPrimary
            : (variant == NxButtonVariant.secondary
                ? NexoraColors.surfaceAlt
                : Colors.transparent));

    final style = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(bg),
      foregroundColor: WidgetStatePropertyAll(fg),
      padding: WidgetStatePropertyAll(_padding),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      ),
      side: variant == NxButtonVariant.outline
          ? const WidgetStatePropertyAll(BorderSide(color: NexoraColors.border))
          : null,
      overlayColor: const WidgetStatePropertyAll(NexoraColors.surfaceHover),
    );

    final button = variant == NxButtonVariant.ghost || variant == NxButtonVariant.outline
        ? OutlinedButton(
            onPressed: onPressed,
            style: style,
            child: contentChild,
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: style,
            child: contentChild,
          );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

enum NxButtonSize { small, medium, large }

/// Standardized icon button.
class NxIconButton extends StatelessWidget {
  const NxIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 20,
    this.color,
    this.backgroundColor,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.all(8),
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        foregroundColor: color ?? NexoraColors.textPrimary,
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        hoverColor: NexoraColors.surfaceHover,
      ),
      icon: IconTheme(
        data: IconThemeData(size: size, color: color ?? NexoraColors.textPrimary),
        child: icon,
      ),
    );
    return button;
  }
}

/// Standardized slider.
class NxSlider extends StatelessWidget {
  const NxSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.label,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: activeColor ?? NexoraColors.textPrimary,
        inactiveTrackColor: inactiveColor ?? NexoraColors.border,
        thumbColor: thumbColor ?? NexoraColors.textPrimary,
        overlayColor: NexoraColors.surfaceHover,
        trackHeight: 3,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
      ),
    );
  }
}

// Aliases
typedef NexoraButton = NxButton;
typedef NexoraIconButton = NxIconButton;
typedef NexoraSlider = NxSlider;