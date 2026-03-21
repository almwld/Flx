import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String label; final TextEditingController? controller; final IconData? prefixIcon;
  final bool obscureText; final TextInputType keyboardType; final String? Function(String?)? validator;
  final int maxLines; final bool enabled;
  const CustomTextField({super.key, required this.label, this.controller, this.prefixIcon,
    this.obscureText = false, this.keyboardType = TextInputType.text, this.validator,
    this.maxLines = 1, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      enabled: enabled,
      textAlign: TextAlign.right,
      style: TextStyle(color: isDark ? AppTheme.darkText : AppTheme.lightText),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppTheme.goldColor) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
      ),
    );
  }
}
