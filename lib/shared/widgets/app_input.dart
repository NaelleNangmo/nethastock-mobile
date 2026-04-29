import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

class AppInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppInput({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.inputFormatters,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: const TextStyle(
            fontFamily: 'DMSans', fontSize: 12,
            fontWeight: FontWeight.w600,
          ).copyWith(color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkText2 : AppColors.lightText2)),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller:       controller,
          validator:        validator,
          keyboardType:     keyboardType,
          obscureText:      obscureText,
          maxLines:         obscureText ? 1 : maxLines,
          inputFormatters:  inputFormatters,
          onChanged:        onChanged,
          readOnly:         readOnly,
          onTap:            onTap,
          style: const TextStyle(fontFamily: 'DMSans', fontSize: 14),
          decoration: InputDecoration(
            hintText:   hint,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
