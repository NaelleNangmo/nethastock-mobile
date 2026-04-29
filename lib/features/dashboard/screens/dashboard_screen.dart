import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth_provider.dart';
import 'dashboard_admin_screen.dart';
import 'dashboard_operator_screen.dart';

/// Routeur de dashboard : affiche Admin ou Opérateur selon le rôle JWT
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _adminRoles = {'admin', 'controller', 'decision_maker', 'accountant'};

  @override
  Widget build(BuildContext context) {
    final role = context.watch<AuthProvider>().user?.role?.name ?? '';
    return _adminRoles.contains(role)
        ? const DashboardAdminScreen()
        : const DashboardOperatorScreen();
  }
}
