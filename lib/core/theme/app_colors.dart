import 'package:flutter/material.dart';

/// Couleurs communes aux deux thèmes
class AppColors {
  AppColors._();

  // ── Couleurs sémantiques (identiques dark & light) ──────────
  static const Color primary      = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color cyan         = Color(0xFF0EA5E9);
  static const Color green        = Color(0xFF10B981);
  static const Color orange       = Color(0xFFF59E0B);
  static const Color red          = Color(0xFFEF4444);
  static const Color purple       = Color(0xFF8B5CF6);

  // ── Thème SOMBRE ────────────────────────────────────────────
  static const Color darkBg       = Color(0xFF0D1117);
  static const Color darkSurface1 = Color(0xFF161B27);
  static const Color darkSurface2 = Color(0xFF1C2333);
  static const Color darkSurface3 = Color(0xFF243047);
  static const Color darkBorder   = Color(0xFF1E2D45);
  static const Color darkText     = Color(0xFFF1F5F9);
  static const Color darkText2    = Color(0xFF94A3B8);
  static const Color darkText3    = Color(0xFF64748B);

  // ── Thème CLAIR ─────────────────────────────────────────────
  static const Color lightBg       = Color(0xFFF8FAFC);
  static const Color lightSurface1 = Color(0xFFFFFFFF);
  static const Color lightSurface2 = Color(0xFFF1F5F9);
  static const Color lightSurface3 = Color(0xFFE2E8F0);
  static const Color lightBorder   = Color(0xFFCBD5E1);
  static const Color lightText     = Color(0xFF0F172A);
  static const Color lightText2    = Color(0xFF475569);
  static const Color lightText3    = Color(0xFF94A3B8);

  // ── Radius ──────────────────────────────────────────────────
  static const double radiusLg = 16.0;
  static const double radiusMd = 12.0;
  static const double radiusSm = 8.0;
}
