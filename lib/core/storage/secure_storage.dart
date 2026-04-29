import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // ── Clés ────────────────────────────────────────────────────
  static const _kAccessToken  = 'access_token';
  static const _kRefreshToken = 'refresh_token';
  static const _kUser         = 'user';
  static const _kTheme        = 'theme';

  // ── Access Token ─────────────────────────────────────────────
  static Future<void>    saveAccessToken(String t)  => _storage.write(key: _kAccessToken, value: t);
  static Future<String?> getAccessToken()           => _storage.read(key: _kAccessToken);
  static Future<void>    deleteAccessToken()        => _storage.delete(key: _kAccessToken);

  // ── Refresh Token ────────────────────────────────────────────
  static Future<void>    saveRefreshToken(String t) => _storage.write(key: _kRefreshToken, value: t);
  static Future<String?> getRefreshToken()          => _storage.read(key: _kRefreshToken);
  static Future<void>    deleteRefreshToken()       => _storage.delete(key: _kRefreshToken);

  // ── User (JSON sérialisé) ────────────────────────────────────
  static Future<void> saveUser(Map<String, dynamic> user) =>
      _storage.write(key: _kUser, value: jsonEncode(user));

  static Future<Map<String, dynamic>?> getUser() async {
    final raw = await _storage.read(key: _kUser);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<void> deleteUser() => _storage.delete(key: _kUser);

  // ── Thème ────────────────────────────────────────────────────
  static Future<void>    saveTheme(String t) => _storage.write(key: _kTheme, value: t);
  static Future<String?> getTheme()          => _storage.read(key: _kTheme);

  // ── Clear all (logout) ───────────────────────────────────────
  static Future<void> clearAuth() async {
    await Future.wait([
      deleteAccessToken(),
      deleteRefreshToken(),
      deleteUser(),
    ]);
  }
}
