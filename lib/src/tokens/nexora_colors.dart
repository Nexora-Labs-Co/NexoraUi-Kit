import 'package:flutter/material.dart';

/// Centralized design tokens for the Nexora suite.
class NexoraColors {
  NexoraColors._();

  // Brand
  static const Color brandCrimson = Color(0xFFA50021);
  static const Color crimson = brandCrimson;
  static const Color accent = brandCrimson;

  // Dark surfaces
  static const Color background = Color(0xFF090C02);
  static const Color surface = Color(0xFF090C02);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceAlt = Color(0xFF1A1A1A);
  static const Color surfaceHover = Color(0xFF2A2A2A);

  // Text
  static const Color foreground = Color(0xFFEBF5EE);
  static const Color textPrimary = foreground;
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFF6B6B6B);
  static const Color textDisabled = Color(0xFF4A4A4A);

  // Borders
  static const Color border = Color(0xFF3A3A3A);
  static const Color borderStrong = Color(0xFF6B6B6B);

  // Legacy aliases
  static const Color muted = textMuted;
  static const Color mutedStrong = textSecondary;
  static const Color danger = textSecondary; // kept neutral
}

/// Alias kept for Nx-prefixed consumers.
typedef NxColors = NexoraColors;
