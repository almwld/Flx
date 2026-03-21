import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final bool isLoading; final bool isOutlined;
  const CustomButton({super.key, required this.text, this.onPressed, this.isLoading = false, this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    final button = isOutlined
        ? OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppTheme.goldColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _child(),
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _child(),
          );
    return SizedBox(height: 50, width: double.infinity, child: button);
  }

  Widget _child() => isLoading
      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
      : Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
}
