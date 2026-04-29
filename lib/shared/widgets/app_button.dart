import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum AppButtonVariant { primary, outline, danger, success }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool fullWidth;
  final double? height;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.fullWidth = true,
    this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bg;
    Color fg;
    Color border;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = AppColors.primary; fg = Colors.white; border = AppColors.primary;
      case AppButtonVariant.outline:
        bg = Colors.transparent;
        fg = isDark ? AppColors.darkText : AppColors.lightText;
        border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
      case AppButtonVariant.danger:
        bg = AppColors.red.withValues(alpha: 0.15);
        fg = AppColors.red;
        border = AppColors.red.withValues(alpha: 0.3);
      case AppButtonVariant.success:
        bg = AppColors.green; fg = Colors.white; border = AppColors.green;
    }

    final child = isLoading
        ? SizedBox(
            width: 20, height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          )
        : Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              Text(label, style: TextStyle(
                fontFamily: 'DMSans', fontSize: 15,
                fontWeight: FontWeight.w700, color: fg,
              )),
            ],
          );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: child,
      ),
    );
  }
}
