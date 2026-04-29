import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // ── Clés ────────────────────────────────────────────────────
  static const _kAccessToken  = 'ns_access_token';
  static const _kRefreshToken = 'ns_refresh_token';
  static const _kUser         = 'ns_user';
  static const _kTheme        = 'ns_theme';

  // ── Helpers sécurisés (ne crashent jamais) ───────────────────
  static Future<void> _write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      debugPrint('[SecureStorage] write error: $e');
    }
  }

  static Future<String?> _read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      debugPrint('[SecureStorage] read error: $e');
      return null;
    }
  }

  static Future<void> _delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      debugPrint('[SecureStorage] delete error: $e');
    }
  }

  // ── Access Token ─────────────────────────────────────────────
  static Future<void>    saveAccessToken(String t)  => _write(_kAccessToken, t);
  static Future<String?> getAccessToken()           => _read(_kAccessToken);
  static Future<void>    deleteAccessToken()        => _delete(_kAccessToken);

  // ── Refresh Token ────────────────────────────────────────────
  static Future<void>    saveRefreshToken(String t) => _write(_kRefreshToken, t);
  static Future<String?> getRefreshToken()          => _read(_kRefreshToken);
  static Future<void>    deleteRefreshToken()       => _delete(_kRefreshToken);

  // ── User ─────────────────────────────────────────────────────
  static Future<void> saveUser(Map<String, dynamic> user) =>
      _write(_kUser, jsonEncode(user));

  static Future<Map<String, dynamic>?> getUser() async {
    final raw = await _read(_kUser);
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<void> deleteUser() => _delete(_kUser);

  // ── Thème ────────────────────────────────────────────────────
  static Future<void>    saveTheme(String t) => _write(_kTheme, t);
  static Future<String?> getTheme()          => _read(_kTheme);

  // ── Clear all (logout) ───────────────────────────────────────
  static Future<void> clearAuth() async {
    await Future.wait([
      deleteAccessToken(),
      deleteRefreshToken(),
      deleteUser(),
    ]);
  }
}
