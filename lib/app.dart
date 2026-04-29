import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/router/app_router.dart';

class NethaStockApp extends StatelessWidget {
  const NethaStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          title: 'NethaStock',
          debugShowCheckedModeBanner: false,
          theme:        AppTheme.light,
          darkTheme:    AppTheme.dark,
          themeMode:    themeProvider.themeMode,
          routerConfig: AppRouter.router,
          // Afficher les erreurs de rendu clairement en dev
          builder: (context, child) {
            ErrorWidget.builder = (details) => Scaffold(
              backgroundColor: const Color(0xFF0D1117),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
                      const SizedBox(height: 16),
                      const Text('Erreur de rendu', style: TextStyle(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,
                      )),
                      const SizedBox(height: 8),
                      Text(
                        details.exceptionAsString(),
                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
            return child ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}
