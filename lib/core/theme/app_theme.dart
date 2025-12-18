import 'package:flutter/material.dart';

class AppTheme {
  // ========== LIGHT MODE COLORS ==========
  static const Color navy = Color(0xFF0D1B2A);
  static const Color gold = Color(0xFFFFB703);
  static const Color platinum = Color(0xFFE0E1DD);
  static const Color white = Colors.white;
  static const Color greyText = Color(0xFF757575);

  // Primary Colors
  static const Color lightPrimaryColor = Color(0xFF1565C0); // Deep Blue
  static const Color lightPrimaryLight = Color(0xFF5E92F3);
  static const Color lightPrimaryDark = Color(0xFF003C8F);

  // Secondary Colors
  static const Color lightSecondaryColor = Color(0xFF2E7D32); // Green
  static const Color lightSecondaryLight = Color(0xFF60AD5E);
  static const Color lightSecondaryDark = Color(0xFF005005);

  // Background & Surface
  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color lightScaffoldBackground = Color(0xFFFAFAFA);

  // Status Colors
  static const Color lightErrorColor = Color(0xFFD32F2F);
  static const Color lightWarningColor = Color(0xFFF57C00);
  static const Color lightSuccessColor = Color(0xFF388E3C);
  static const Color lightInfoColor = Color(0xFF1976D2);

  // Text Colors
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextDisabled = Color(0xFFBDBDBD);

  // ========== DARK MODE COLORS ==========

  // Primary Colors
  static const Color darkPrimaryColor = Color(0xFF42A5F5);
  static const Color darkPrimaryLight = Color(0xFF80D6FF);
  static const Color darkPrimaryDark = Color(0xFF0077C2);

  // Secondary Colors
  static const Color darkSecondaryColor = Color(0xFF66BB6A);
  static const Color darkSecondaryLight = Color(0xFF98EE99);
  static const Color darkSecondaryDark = Color(0xFF338A3E);

  // Background & Surface
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkScaffoldBackground = Color(0xFF181818);

  // Status Colors
  static const Color darkErrorColor = Color(0xFFEF5350);
  static const Color darkWarningColor = Color(0xFFFF9800);
  static const Color darkSuccessColor = Color(0xFF66BB6A);
  static const Color darkInfoColor = Color(0xFF42A5F5);

  // Text Colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextDisabled = Color(0xFF6B6B6B);

  // ========== LIGHT THEME ==========
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: lightPrimaryColor,
        onPrimary: Colors.white,
        primaryContainer: lightPrimaryLight,
        onPrimaryContainer: lightPrimaryDark,
        secondary: lightSecondaryColor,
        onSecondary: Colors.white,
        secondaryContainer: lightSecondaryLight,
        onSecondaryContainer: lightSecondaryDark,
        error: lightErrorColor,
        onError: Colors.white,
        errorContainer: lightErrorColor.withOpacity(0.1),
        onErrorContainer: lightErrorColor,
        surface: lightSurfaceColor,
        onSurface: lightTextPrimary,
        onSurfaceVariant: lightTextSecondary,
        outline: lightTextDisabled,
        shadow: Colors.black.withOpacity(0.1),
        scrim: Colors.black.withOpacity(0.4),
        inverseSurface: darkSurfaceColor,
        onInverseSurface: darkTextPrimary,
        inversePrimary: darkPrimaryColor,
        surfaceTint: lightPrimaryColor,
      ),
      scaffoldBackgroundColor: lightScaffoldBackground,
      cardColor: lightSurfaceColor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: lightSurfaceColor,
        foregroundColor: lightTextPrimary,
        iconTheme: IconThemeData(color: lightTextPrimary),
        titleTextStyle: TextStyle(
          color: lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: lightSurfaceColor,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: lightPrimaryColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightTextDisabled),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightTextDisabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightErrorColor),
        ),
        labelStyle: TextStyle(color: lightTextSecondary),
        hintStyle: TextStyle(color: lightTextDisabled),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: lightTextPrimary),
        displayMedium: TextStyle(color: lightTextPrimary),
        displaySmall: TextStyle(color: lightTextPrimary),
        headlineLarge: TextStyle(color: lightTextPrimary),
        headlineMedium: TextStyle(color: lightTextPrimary),
        headlineSmall: TextStyle(color: lightTextPrimary),
        titleLarge: TextStyle(color: lightTextPrimary),
        titleMedium: TextStyle(color: lightTextPrimary),
        titleSmall: TextStyle(color: lightTextPrimary),
        bodyLarge: TextStyle(color: lightTextPrimary),
        bodyMedium: TextStyle(color: lightTextPrimary),
        bodySmall: TextStyle(color: lightTextSecondary),
        labelLarge: TextStyle(color: lightTextPrimary),
        labelMedium: TextStyle(color: lightTextSecondary),
        labelSmall: TextStyle(color: lightTextDisabled),
      ),
      iconTheme: IconThemeData(color: lightTextPrimary),
      dividerTheme: DividerThemeData(
        color: lightTextDisabled.withOpacity(0.3),
        thickness: 0.5,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: lightSurfaceColor,
        indicatorColor: lightSecondaryColor.withOpacity(0.2),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              color: lightSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return TextStyle(
            color: lightTextSecondary,
            fontSize: 12,
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              color: lightSecondaryColor,
              size: 24,
            );
          }
          return IconThemeData(
            color: lightTextSecondary,
            size: 24,
          );
        }),
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: lightSurfaceColor,
        selectedIconTheme: IconThemeData(
          color: lightSecondaryColor,
          size: 28,
        ),
        selectedLabelTextStyle: TextStyle(
          color: lightSecondaryColor,
          fontWeight: FontWeight.w600,
        ),
        indicatorColor: lightSecondaryColor.withOpacity(0.2),
      ),
    );
  }

  // ========== DARK THEME ==========
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: darkPrimaryColor,
        onPrimary: Colors.black,
        primaryContainer: darkPrimaryLight,
        onPrimaryContainer: darkPrimaryDark,
        secondary: darkSecondaryColor,
        onSecondary: Colors.black,
        secondaryContainer: darkSecondaryLight,
        onSecondaryContainer: darkSecondaryDark,
        error: darkErrorColor,
        onError: Colors.white,
        errorContainer: darkErrorColor.withOpacity(0.1),
        onErrorContainer: darkErrorColor,
        surface: darkSurfaceColor,
        onSurface: darkTextPrimary,
        onSurfaceVariant: darkTextSecondary,
        outline: darkTextDisabled,
        shadow: Colors.black.withOpacity(0.3),
        scrim: Colors.black.withOpacity(0.6),
        inverseSurface: lightSurfaceColor,
        onInverseSurface: lightTextPrimary,
        inversePrimary: lightPrimaryColor,
        surfaceTint: darkPrimaryColor,
      ),
      scaffoldBackgroundColor: darkScaffoldBackground,
      cardColor: darkSurfaceColor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkSurfaceColor,
        foregroundColor: darkTextPrimary,
        iconTheme: IconThemeData(color: darkTextPrimary),
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: darkSurfaceColor,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: darkPrimaryColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkTextDisabled),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkTextDisabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkErrorColor),
        ),
        labelStyle: TextStyle(color: darkTextSecondary),
        hintStyle: TextStyle(color: darkTextDisabled),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: darkTextPrimary),
        displayMedium: TextStyle(color: darkTextPrimary),
        displaySmall: TextStyle(color: darkTextPrimary),
        headlineLarge: TextStyle(color: darkTextPrimary),
        headlineMedium: TextStyle(color: darkTextPrimary),
        headlineSmall: TextStyle(color: darkTextPrimary),
        titleLarge: TextStyle(color: darkTextPrimary),
        titleMedium: TextStyle(color: darkTextPrimary),
        titleSmall: TextStyle(color: darkTextPrimary),
        bodyLarge: TextStyle(color: darkTextPrimary),
        bodyMedium: TextStyle(color: darkTextPrimary),
        bodySmall: TextStyle(color: darkTextSecondary),
        labelLarge: TextStyle(color: darkTextPrimary),
        labelMedium: TextStyle(color: darkTextSecondary),
        labelSmall: TextStyle(color: darkTextDisabled),
      ),
      iconTheme: IconThemeData(color: darkTextPrimary),
      dividerTheme: DividerThemeData(
        color: darkTextDisabled.withOpacity(0.3),
        thickness: 0.5,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkSurfaceColor,
        indicatorColor: darkSecondaryColor.withOpacity(0.2),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              color: darkSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return TextStyle(
            color: darkTextSecondary,
            fontSize: 12,
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              color: darkSecondaryColor,
              size: 24,
            );
          }
          return IconThemeData(
            color: darkTextSecondary,
            size: 24,
          );
        }),
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: darkSurfaceColor,
        selectedIconTheme: IconThemeData(
          color: darkSecondaryColor,
          size: 28,
        ),
        selectedLabelTextStyle: TextStyle(
          color: darkSecondaryColor,
          fontWeight: FontWeight.w600,
        ),
        indicatorColor: darkSecondaryColor.withOpacity(0.2),
      ),
    );
  }

  // ========== STATUS COLOR HELPERS ==========

  /// Get error color based on theme brightness
  static Color errorColor(Brightness brightness) {
    return brightness == Brightness.dark ? darkErrorColor : lightErrorColor;
  }

  /// Get warning color based on theme brightness
  static Color warningColor(Brightness brightness) {
    return brightness == Brightness.dark ? darkWarningColor : lightWarningColor;
  }

  /// Get success color based on theme brightness
  static Color successColor(Brightness brightness) {
    return brightness == Brightness.dark ? darkSuccessColor : lightSuccessColor;
  }

  /// Get info color based on theme brightness
  static Color infoColor(Brightness brightness) {
    return brightness == Brightness.dark ? darkInfoColor : lightInfoColor;
  }
}
