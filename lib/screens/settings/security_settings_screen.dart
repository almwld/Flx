import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'الأمان والخصوصية'),
      body: Center(
        child: Text('الأمان - قيد التطوير', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
      ),
    );
  }
}
