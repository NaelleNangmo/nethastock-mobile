import '../../../shared/models/user_model.dart';

// Réexport pour que les autres fichiers du module puissent importer SiteModel via auth_model
export '../../../shared/models/site_model.dart' show SiteModel;

class LoginRequest {
  final String email;
  final String password;
  final int? siteId;

  const LoginRequest({
    required this.email,
    required this.password,
    this.siteId,
  });

  Map<String, dynamic> toJson() => {
    'email':    email.toLowerCase().trim(),
    'password': password,
    if (siteId != null) 'site_id': siteId,
  };
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> j) => AuthResponse(
    accessToken:  j['accessToken']  as String,
    refreshToken: j['refreshToken'] as String,
    user: UserModel.fromJson(j['user'] as Map<String, dynamic>),
  );
}

class RefreshResponse {
  final String accessToken;
  const RefreshResponse({required this.accessToken});

  factory RefreshResponse.fromJson(Map<String, dynamic> j) =>
      RefreshResponse(accessToken: j['accessToken'] as String);
}
