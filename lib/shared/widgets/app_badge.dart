import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum BadgeColor { green, orange, red, blue, purple, cyan, grey }

class AppBadge extends StatelessWidget {
  final String label;
  final BadgeColor color;

  const AppBadge({super.key, required this.label, this.color = BadgeColor.blue});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (color) {
      BadgeColor.green  => (AppColors.green.withValues(alpha: 0.15),  AppColors.green),
      BadgeColor.orange => (AppColors.orange.withValues(alpha: 0.15), AppColors.orange),
      BadgeColor.red    => (AppColors.red.withValues(alpha: 0.15),    AppColors.red),
      BadgeColor.blue   => (AppColors.primary.withValues(alpha: 0.15),AppColors.primaryLight),
      BadgeColor.purple => (AppColors.purple.withValues(alpha: 0.15), AppColors.purple),
      BadgeColor.cyan   => (AppColors.cyan.withValues(alpha: 0.15),   AppColors.cyan),
      BadgeColor.grey   => (Colors.grey.withValues(alpha: 0.15),      Colors.grey),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(
        fontFamily: 'DMSans', fontSize: 10,
        fontWeight: FontWeight.w700, color: fg,
        letterSpacing: 0.5,
      )),
    );
  }
}
