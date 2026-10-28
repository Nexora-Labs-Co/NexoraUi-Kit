import 'package:flutter/material.dart';

import 'nexora_colors.dart';

class NexoraTheme {
  NexoraTheme._();

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final scheme = const ColorScheme.dark(
      primary: NexoraColors.foreground,
      onPrimary: NexoraColors.background,
      secondary: NexoraColors.mutedStrong,
      onSecondary: NexoraColors.background,
      surface: NexoraColors.surface,
      onSurface: NexoraColors.foreground,
      error: NexoraColors.foreground,
      onError: NexoraColors.background,
      outline: NexoraColors.border,
      surfaceContainerHighest: NexoraColors.surfaceAlt,
    );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: NexoraColors.background,
      canvasColor: NexoraColors.background,
      dividerColor: NexoraColors.border,
      cardColor: NexoraColors.surface,
      textTheme: base.textTheme.apply(
        bodyColor: NexoraColors.foreground,
        displayColor: NexoraColors.foreground,
        fontFamily: 'monospace',
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: NexoraColors.background,
        foregroundColor: NexoraColors.foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: NexoraColors.surfaceAlt,
        hintStyle: const TextStyle(color: NexoraColors.muted),
        labelStyle: const TextStyle(color: NexoraColors.mutedStrong),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NexoraColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NexoraColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NexoraColors.foreground),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: NexoraColors.foreground,
          foregroundColor: NexoraColors.background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: NexoraColors.foreground,
          side: const BorderSide(color: NexoraColors.borderStrong),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: NexoraColors.foreground,
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: NexoraColors.foreground,
          hoverColor: NexoraColors.surfaceHover,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: NexoraColors.surfaceAlt,
        textStyle: const TextStyle(color: NexoraColors.foreground, fontSize: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: NexoraColors.border),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: NexoraColors.surfaceAlt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: NexoraColors.border),
          ),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: NexoraColors.surfaceAlt,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: NexoraColors.border),
        ),
        textStyle: const TextStyle(color: NexoraColors.foreground, fontSize: 12),
      ),
    );
  }
}
