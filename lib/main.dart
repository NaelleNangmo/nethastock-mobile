import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/theme/theme_provider.dart';
import 'features/auth/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Ajoutés module par module :
        // ChangeNotifierProvider(create: (_) => DashboardProvider()),
        // ChangeNotifierProvider(create: (_) => ProductProvider()),
        // ChangeNotifierProvider(create: (_) => MovementProvider()),
        // ChangeNotifierProvider(create: (_) => InventoryProvider()),
        // ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const NethaStockApp(),
    ),
  );
}
