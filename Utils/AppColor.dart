import 'package:flutter/material.dart';

class AppColor {
  // ============================================================
  // PRIMARY GRADIENT COLORS (Main Background)
  // ============================================================
  static const Color gradientStart = Color(0xFF1A1A2E);
  static const Color gradientMid = Color(0xFF16213E);
  static const Color gradientEnd = Color(0xFF0F3460);

  // Light Mode Background Colors
  static const Color lightGradientStart = Color(0xFFF5F5F5);
  static const Color lightGradientMid = Color(0xFFE8E8E8);
  static const Color lightGradientEnd = Color(0xFFD4D4D4);

  // ============================================================
  // ONBOARDING SCREEN GRADIENTS
  // ============================================================
  // Light Theme - Light Green/Blue/White Shades
  static const List<Color> onboardingLightGradient = [
    Color(0xFFE8F5E9), // Light Green
    Color(0xFFB3E5FC), // Light Blue
    Color(0xFFF5F5F5), // White
  ];

  // Dark Theme - Very Dark Background
  static const List<Color> onboardingDarkGradient = [
    Color(0xFF0A0A0A), // Very Dark
    Color(0xFF1A1A2E), // Dark Navy
    Color(0xFF0D0D1A), // Almost Black
  ];

  // ============================================================
  // BRAND / ACCENT COLORS (Gold Theme)
  // ============================================================
  static const Color goldLight = Color(0xFFF6E9A0);
  static const Color gold = Color(0xFFF2C94C);
  static const Color goldDark = Color(0xFFF2994A);

  // ============================================================
  // TEXT COLORS
  // ============================================================
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA6B0C9);
  static const Color textTertiary = Color(0xFF6B7A9A);

  // Light Mode Text Colors
  static const Color lightTextPrimary = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF4A4A6A);
  static const Color lightTextTertiary = Color(0xFF8A8AAE);

  // ============================================================
  // STATUS BAR COLORS
  // ============================================================
  static const Color statusBarText = Color(0xFFFFFFFF);
  static const Color statusBarBg = Color(0x0FFFFFFF);

  // ============================================================
  // PRIMARY APP COLOR
  // ============================================================
  static const Color primary = Color(0xFF2FA84F);

  // ============================================================
  // BUTTON COLORS
  // ============================================================
  static const Color buttonPrimary = Color(0xFFF2C94C);
  static const Color buttonText = Color(0xFF0B0B1A);
  static const Color buttonSkip = Color(0x80FFFFFF);

  // ============================================================
  // PAGINATION DOTS
  // ============================================================
  static const Color dotActive = Color(0xFFF2C94C);
  static const Color dotInactive = Color(0x26FFFFFF);

  // ============================================================
  // SHADOWS & GLOWS
  // ============================================================
  static Color get shadowGold => const Color(0xFFF2C94C).withOpacity(0.3);

  // ============================================================
  // OVERLAYS & BORDERS
  // ============================================================
  static Color get overlayLight => const Color(0xFFFFFFFF).withOpacity(0.04);
  static Color get overlayMedium => const Color(0xFFFFFFFF).withOpacity(0.10);
  static Color get cardBorder => const Color(0xFFFFFFFF).withOpacity(0.04);

  // ============================================================
  // ONBOARDING IMAGE GRADIENTS (Per Page)
  // ============================================================
  static const List<Color> imageGradient1 = [
    Color(0xFF5B4A7A),
    Color(0xFF1F1F44),
  ];
  static const List<Color> imageGradient2 = [
    Color(0xFF3F5A7A),
    Color(0xFF142233),
  ];
  static const List<Color> imageGradient3 = [
    Color(0xFF6A4A5A),
    Color(0xFF221A2A),
  ];

  // ============================================================
  // HELPER METHODS
  // ============================================================

  /// Get main background gradient based on theme
  static LinearGradient getMainBackgroundGradient(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          gradientStart,
          gradientMid,
          gradientEnd,
        ],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          lightGradientStart,
          lightGradientMid,
          lightGradientEnd,
        ],
      );
    }
  }

  /// Get onboarding screen gradient based on theme
  static LinearGradient getOnboardingGradient(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: onboardingDarkGradient,
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: onboardingLightGradient,
      );
    }
  }

  /// Get text primary color based on theme
  static Color getTextPrimary(Brightness brightness) {
    return brightness == Brightness.dark ? textPrimary : lightTextPrimary;
  }

  /// Get text secondary color based on theme
  static Color getTextSecondary(Brightness brightness) {
    return brightness == Brightness.dark ? textSecondary : lightTextSecondary;
  }

  /// Get text tertiary color based on theme
  static Color getTextTertiary(Brightness brightness) {
    return brightness == Brightness.dark ? textTertiary : lightTextTertiary;
  }

  /// Get image gradient by page index
  static List<Color> getImageGradient(int index) {
    switch (index) {
      case 0:
        return imageGradient1;
      case 1:
        return imageGradient2;
      case 2:
        return imageGradient3;
      default:
        return imageGradient1;
    }
  }

  /// Apply opacity to any color
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Get gold gradient for brand text
  static LinearGradient get goldGradient {
    return const LinearGradient(
      colors: [
        goldLight,
        gold,
        goldDark,
      ],
    );
  }
}