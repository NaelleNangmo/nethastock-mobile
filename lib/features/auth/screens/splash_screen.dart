import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;
  late Animation<double> _taglineFade;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)),
    );
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );
    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _ctrl.forward();
    _init();
  }

  Future<void> _init() async {
    // Laisser l'animation se jouer
    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;

    try {
      // Vérifier l'état d'authentification
      await context.read<AuthProvider>().checkAuth();
      if (!mounted) return;

      final status = context.read<AuthProvider>().status;
      if (status == AuthStatus.authenticated) {
        context.go('/dashboard');
      } else {
        context.go('/login');
      }
    } catch (e) {
      debugPrint('[Splash] Erreur init: $e');
      if (mounted) context.go('/login');
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D1B3E), Color(0xFF0D1117)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Logo animé ──────────────────────────────────
              FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  scale: _scale,
                  child: Container(
                    width: 88, height: 88,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.cyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.45),
                          blurRadius: 40,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('📦', style: TextStyle(fontSize: 40)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Nom ─────────────────────────────────────────
              FadeTransition(
                opacity: _fade,
                child: const Text(
                  'NETHASTOCK',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkText,
                    letterSpacing: 3,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // ── Tagline ──────────────────────────────────────
              FadeTransition(
                opacity: _taglineFade,
                child: const Text(
                  'Gestion de stock intelligente',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 13,
                    color: AppColors.darkText3,
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // ── Loader ───────────────────────────────────────
              FadeTransition(
                opacity: _taglineFade,
                child: SizedBox(
                  width: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: const LinearProgressIndicator(
                      backgroundColor: AppColors.darkSurface3,
                      color: AppColors.primary,
                      minHeight: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
