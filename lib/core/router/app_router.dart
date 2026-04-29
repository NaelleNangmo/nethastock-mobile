import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';

// Placeholder dashboard – remplacé dans feat/module-dashboard
class _DashboardPlaceholder extends StatelessWidget {
  const _DashboardPlaceholder();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('✅ Connecté !', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await context.read<AuthProvider>().logout();
                if (context.mounted) context.go('/login');
              },
              child: const Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Pas de redirection forcée ici – géré dans SplashScreen
      return null;
    },
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
        builder: (ctx, state) => const _DashboardPlaceholder(),
      ),
      // Ajoutés module par module :
      // GoRoute(path: '/products',  ...),
      // GoRoute(path: '/inventory', ...),
      // GoRoute(path: '/movements', ...),
      // GoRoute(path: '/users',     ...),
      // GoRoute(path: '/profile',   ...),
    ],
  );
}
