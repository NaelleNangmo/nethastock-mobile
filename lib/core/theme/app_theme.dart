import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // ── THÈME SOMBRE ────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'DMSans',
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary:   AppColors.primary,
      secondary: AppColors.cyan,
      surface:   AppColors.darkSurface1,
      error:     AppColors.red,
      onPrimary: Colors.white,
      onSurface: AppColors.darkText,
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBg,
      foregroundColor: AppColors.darkText,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'DMSans', fontSize: 17,
        fontWeight: FontWeight.w700, color: AppColors.darkText,
      ),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface1,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.darkText3,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(fontFamily: 'DMSans', fontSize: 9, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontFamily: 'DMSans', fontSize: 9, fontWeight: FontWeight.w600),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.darkSurface1,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        side: const BorderSide(color: AppColors.darkBorder),
      ),
    ),

    // InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      hintStyle: const TextStyle(color: AppColors.darkText3, fontFamily: 'DMSans', fontSize: 14),
      labelStyle: const TextStyle(color: AppColors.darkText2, fontFamily: 'DMSans', fontSize: 12),
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontFamily: 'DMSans', fontSize: 15, fontWeight: FontWeight.w700),
        elevation: 0,
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkText,
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: AppColors.darkBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontFamily: 'DMSans', fontSize: 15, fontWeight: FontWeight.w700),
      ),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.darkBorder, thickness: 1, space: 0,
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? Colors.white : AppColors.darkText3),
      trackColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? AppColors.green : AppColors.darkSurface3),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkSurface2,
      selectedColor: AppColors.primary,
      labelStyle: const TextStyle(fontFamily: 'DMSans', fontSize: 11, fontWeight: FontWeight.w600),
      side: const BorderSide(color: AppColors.darkBorder),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
  );

  // ── THÈME CLAIR ─────────────────────────────────────────────
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'DMSans',
    scaffoldBackgroundColor: AppColors.lightBg,
    colorScheme: const ColorScheme.light(
      primary:   AppColors.primary,
      secondary: AppColors.cyan,
      surface:   AppColors.lightSurface1,
      error:     AppColors.red,
      onPrimary: Colors.white,
      onSurface: AppColors.lightText,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSurface1,
      foregroundColor: AppColors.lightText,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'DMSans', fontSize: 17,
        fontWeight: FontWeight.w700, color: AppColors.lightText,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurface1,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightText3,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(fontFamily: 'DMSans', fontSize: 9, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontFamily: 'DMSans', fontSize: 9, fontWeight: FontWeight.w600),
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightSurface1,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        side: const BorderSide(color: AppColors.lightBorder),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurface2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        borderSide: const BorderSide(color: AppColors.lightBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        borderSide: const BorderSide(color: AppColors.lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      hintStyle: const TextStyle(color: AppColors.lightText3, fontFamily: 'DMSans', fontSize: 14),
      labelStyle: const TextStyle(color: AppColors.lightText2, fontFamily: 'DMSans', fontSize: 12),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontFamily: 'DMSans', fontSize: 15, fontWeight: FontWeight.w700),
        elevation: 0,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.lightText,
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: AppColors.lightBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontFamily: 'DMSans', fontSize: 15, fontWeight: FontWeight.w700),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.lightBorder, thickness: 1, space: 0,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? Colors.white : AppColors.lightText3),
      trackColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? AppColors.green : AppColors.lightSurface3),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightSurface2,
      selectedColor: AppColors.primary,
      labelStyle: const TextStyle(fontFamily: 'DMSans', fontSize: 11, fontWeight: FontWeight.w600),
      side: const BorderSide(color: AppColors.lightBorder),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
  );
}
