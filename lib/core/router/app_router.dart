import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';

class AppRouter {
  AppRouter._();

  // Lazy : créé seulement quand on y accède pour la première fois
  static GoRouter? _router;

  static GoRouter get router {
    _router ??= GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: false,
      routes: [
        GoRoute(
          path: '/',
          builder: (ctx, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (ctx, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (ctx, state) => const DashboardScreen(),
        ),
        // Ajoutés module par module :
        // GoRoute(path: '/products',          ...),
        // GoRoute(path: '/products/:id',      ...),
        // GoRoute(path: '/scanner',           ...),
        // GoRoute(path: '/inventory',         ...),
        // GoRoute(path: '/movements/new',     ...),
        // GoRoute(path: '/movements/transfer',...),
        // GoRoute(path: '/movements/history', ...),
        // GoRoute(path: '/movements/:id',     ...),
        // GoRoute(path: '/users',             ...),
        // GoRoute(path: '/profile',           ...),
      ],
    );
    return _router!;
  }
}
