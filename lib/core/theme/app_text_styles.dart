import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── DM Sans ─────────────────────────────────────────────────
  static const TextStyle h1 = TextStyle(
    fontFamily: 'DMSans', fontSize: 24, fontWeight: FontWeight.w800, height: 1.2,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'DMSans', fontSize: 20, fontWeight: FontWeight.w800, height: 1.3,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'DMSans', fontSize: 17, fontWeight: FontWeight.w700, height: 1.3,
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'DMSans', fontSize: 14, fontWeight: FontWeight.w400, height: 1.5,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'DMSans', fontSize: 14, fontWeight: FontWeight.w500, height: 1.5,
  );
  static const TextStyle bodySemiBold = TextStyle(
    fontFamily: 'DMSans', fontSize: 14, fontWeight: FontWeight.w600, height: 1.5,
  );
  static const TextStyle bodyBold = TextStyle(
    fontFamily: 'DMSans', fontSize: 14, fontWeight: FontWeight.w700, height: 1.5,
  );
  static const TextStyle small = TextStyle(
    fontFamily: 'DMSans', fontSize: 12, fontWeight: FontWeight.w400, height: 1.4,
  );
  static const TextStyle smallBold = TextStyle(
    fontFamily: 'DMSans', fontSize: 12, fontWeight: FontWeight.w700, height: 1.4,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  static const TextStyle label = TextStyle(
    fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w800,
    letterSpacing: 1.5,
  );

  // ── DM Mono (références, codes, quantités) ──────────────────
  static const TextStyle mono = TextStyle(
    fontFamily: 'DMMono', fontSize: 12, fontWeight: FontWeight.w400,
  );
  static const TextStyle monoMedium = TextStyle(
    fontFamily: 'DMMono', fontSize: 12, fontWeight: FontWeight.w500,
  );
  static const TextStyle monoBig = TextStyle(
    fontFamily: 'DMMono', fontSize: 20, fontWeight: FontWeight.w700,
  );
}
