class Validators {
  Validators._();

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email requis';
    final re = RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$', caseSensitive: false);
    if (!re.hasMatch(v.trim())) return 'Email invalide';
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Mot de passe requis';
    if (v.length < 6) return 'Minimum 6 caractères';
    return null;
  }

  static String? required(String? v, [String field = 'Ce champ']) {
    if (v == null || v.trim().isEmpty) return '$field est requis';
    return null;
  }

  static String? positiveInt(String? v, [String field = 'La valeur']) {
    if (v == null || v.trim().isEmpty) return '$field est requise';
    final n = int.tryParse(v.trim());
    if (n == null || n < 0) return '$field doit être un entier positif';
    return null;
  }
}
