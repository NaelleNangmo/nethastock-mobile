import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';

// Les autres screens seront importés au fur et à mesure des modules
// import '../../features/dashboard/screens/dashboard_admin_screen.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/',      builder: (ctx, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (ctx, state) => const LoginScreen()),
      // Les routes suivantes seront ajoutées module par module :
      // GoRoute(path: '/dashboard', ...),
      // GoRoute(path: '/products',  ...),
      // GoRoute(path: '/inventory', ...),
      // GoRoute(path: '/movements', ...),
      // GoRoute(path: '/users',     ...),
      // GoRoute(path: '/profile',   ...),
    ],
  );
}
