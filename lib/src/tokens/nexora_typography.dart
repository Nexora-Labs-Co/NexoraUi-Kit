import 'package:flutter/material.dart';

import 'nexora_colors.dart';

/// Centralized typography tokens for the Nexora suite.
class NexoraTypography {
  NexoraTypography._();

  static const String displayFont = 'Gliker';
  static const String bodyFont = 'monospace';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: displayFont,
    fontSize: 96,
    fontWeight: FontWeight.w700,
    height: 1.0,
    color: NexoraColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: displayFont,
    fontSize: 64,
    fontWeight: FontWeight.w700,
    height: 1.05,
    color: NexoraColors.textPrimary,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: displayFont,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: NexoraColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: displayFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.15,
    color: NexoraColors.textPrimary,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: NexoraColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: NexoraColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: NexoraColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: NexoraColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.35,
    color: NexoraColors.textMuted,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: NexoraColors.textPrimary,
  );
}

typedef NxTypography = NexoraTypography;
typedef NexoraTextStyles = NexoraTypography;
typedef NxTextStyles = NexoraTypography;