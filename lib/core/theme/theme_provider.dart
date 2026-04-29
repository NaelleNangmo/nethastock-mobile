import 'package:flutter/material.dart';
import '../storage/secure_storage.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true; // dark par défaut

  bool      get isDark    => _isDark;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  /// Charger la préférence sauvegardée — ne crashe jamais
  Future<void> load() async {
    try {
      final saved = await SecureStorage.getTheme();
      _isDark = saved != 'light'; // null ou 'dark' → dark
    } catch (_) {
      _isDark = true;
    }
    // Pas de notifyListeners ici : appelé avant runApp
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    await SecureStorage.saveTheme(_isDark ? 'dark' : 'light');
    notifyListeners();
  }
}
