import 'package:flutter/material.dart';
import '../../../shared/models/user_model.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.unknown;
  UserModel? _user;
  String? _error;
  bool _isLoading = false;

  // Sites pour le dropdown login
  List<SiteModel> _sites = [];
  bool _sitesLoading = false;

  AuthStatus get status     => _status;
  UserModel? get user       => _user;
  String?    get error      => _error;
  bool       get isLoading  => _isLoading;
  List<SiteModel> get sites => _sites;
  bool get sitesLoading     => _sitesLoading;

  // ── Initialisation (appelée au splash) ──────────────────────
  Future<void> checkAuth() async {
    final loggedIn = await AuthService.isLoggedIn();
    if (loggedIn) {
      final raw = await AuthService.getStoredUser();
      if (raw != null) _user = UserModel.fromJson(raw);
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  // ── Charger les sites ────────────────────────────────────────
  Future<void> loadSites() async {
    _sitesLoading = true;
    notifyListeners();
    try {
      _sites = await AuthService.getSites();
    } catch (_) {
      _sites = [];
    } finally {
      _sitesLoading = false;
      notifyListeners();
    }
  }

  // ── Login ────────────────────────────────────────────────────
  Future<bool> login(String email, String password, int? siteId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final auth = await AuthService.login(
        LoginRequest(email: email, password: password, siteId: siteId),
      );
      _user   = auth.user;
      _status = AuthStatus.authenticated;
      _isLoading = false;
      notifyListeners();
      return true;
    } on Exception catch (e) {
      _error = _parseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ── Logout ───────────────────────────────────────────────────
  Future<void> logout() async {
    await AuthService.logout();
    _user   = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  String _parseError(Exception e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('401') || msg.contains('incorrect') || msg.contains('invalide')) {
      return 'Email ou mot de passe incorrect';
    }
    if (msg.contains('inactif') || msg.contains('inactive')) {
      return 'Compte désactivé. Contactez votre administrateur.';
    }
    if (msg.contains('site')) {
      return 'Site de connexion incorrect';
    }
    if (msg.contains('connection') || msg.contains('network') || msg.contains('socket')) {
      return 'Impossible de joindre le serveur. Vérifiez votre connexion.';
    }
    return 'Une erreur est survenue. Réessayez.';
  }
}
