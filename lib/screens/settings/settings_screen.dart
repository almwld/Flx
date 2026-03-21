import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> settings = [
      {'title': 'الإشعارات', 'icon': Icons.notifications_outlined, 'route': '/notifications_settings'},
      {'title': 'الأمان', 'icon': Icons.security, 'route': '/security_settings'},
      {'title': 'اللغة', 'icon': Icons.language, 'route': '/language'},
      {'title': 'طرق الدفع', 'icon': Icons.payment, 'route': '/payment_methods'},
      {'title': 'المساعدة والدعم', 'icon': Icons.help_outline, 'route': '/help_support'},
      {'title': 'عن التطبيق', 'icon': Icons.info_outline, 'route': '/about'},
      {'title': 'سياسة الخصوصية', 'icon': Icons.privacy_tip_outlined, 'route': '/privacy_policy'},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإعدادات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(settings[index]['icon'], color: AppTheme.goldColor),
              title: Text(settings[index]['title'], style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, settings[index]['route']),
            ),
          );
        },
      ),
    );
  }
}
