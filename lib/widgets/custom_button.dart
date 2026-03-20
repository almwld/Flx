import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final bool isLoading; final bool isOutlined; final IconData? icon; final Color? color;
  const CustomButton({super.key, required this.text, this.onPressed, this.isLoading = false, this.isOutlined = false, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppTheme.goldColor;
    if (isOutlined) {
      return SizedBox(
        height: 55,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(foregroundColor: buttonColor, side: BorderSide(color: buttonColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          child: _buildChild(),
        ),
      );
    }
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: isLoading ? 0 : 2),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (isLoading) return const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black));
    if (icon != null) return Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(text, style: const TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold))]);
    return Text(text, style: const TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold));
  }
}
