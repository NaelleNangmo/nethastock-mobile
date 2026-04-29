import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_input.dart';

/// Écran de connexion – implémentation complète dans feat/module-auth
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Logo
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.cyan],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(child: Text('📦', style: TextStyle(fontSize: 24))),
              ),
              const SizedBox(height: 14),
              const Text('Connexion', style: TextStyle(
                fontFamily: 'DMSans', fontSize: 22, fontWeight: FontWeight.w800,
              )),
              const SizedBox(height: 4),
              const Text('Accédez à votre espace de travail', style: TextStyle(
                fontFamily: 'DMSans', fontSize: 13, color: AppColors.darkText3,
              )),
              const SizedBox(height: 32),
              // Formulaire (sera connecté à l'API dans feat/module-auth)
              AppInput(label: 'Adresse e-mail', hint: 'exemple@nethastock.com',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              AppInput(label: 'Mot de passe', hint: '••••••••', obscureText: true),
              const SizedBox(height: 24),
              AppButton(label: 'Se connecter', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
