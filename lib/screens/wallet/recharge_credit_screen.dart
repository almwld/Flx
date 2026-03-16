import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class RechargeCreditScreen extends StatelessWidget {
  const RechargeCreditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: const CustomAppBar(title: 'شحن الرصيد'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: isDark ? AppTheme.goldColor.withOpacity(0.5) : AppTheme.goldColor.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'قيد التطوير',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Changa',
                color: isDark ? AppTheme.darkText : AppTheme.lightText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'سيتم إضافة هذه الخدمة قريباً',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Changa',
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
