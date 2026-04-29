import 'package:flutter/material.dart';
import '../storage/secure_storage.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  /// Charger la préférence sauvegardée au démarrage
  Future<void> load() async {
    final saved = await SecureStorage.getTheme();
    _isDark = saved != 'light';
    notifyListeners();
  }

  /// Basculer entre dark et light
  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    await SecureStorage.saveTheme(_isDark ? 'dark' : 'light');
    notifyListeners();
  }
}
