import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import 'notifications_settings_screen.dart';
import 'security_settings_screen.dart';
import 'language_screen.dart';
import 'payment_methods_screen.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';
import 'help_support_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final List<Map<String, dynamic>> _settings = const [
    {'title': 'الإشعارات', 'icon': Icons.notifications, 'color': Colors.blue, 'screen': NotificationsSettingsScreen},
    {'title': 'الأمان والخصوصية', 'icon': Icons.security, 'color': Colors.green, 'screen': SecuritySettingsScreen},
    {'title': 'اللغة', 'icon': Icons.language, 'color': Colors.orange, 'screen': LanguageScreen},
    {'title': 'طرق الدفع', 'icon': Icons.payment, 'color': Colors.purple, 'screen': PaymentMethodsScreen},
    {'title': 'المساعدة والدعم', 'icon': Icons.help, 'color': Colors.teal, 'screen': HelpSupportScreen},
    {'title': 'عن التطبيق', 'icon': Icons.info, 'color': Colors.red, 'screen': AboutScreen},
    {'title': 'سياسة الخصوصية', 'icon': Icons.privacy_tip, 'color': Colors.indigo, 'screen': PrivacyPolicyScreen},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'الإعدادات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _settings.length,
        itemBuilder: (context, index) {
          final item = _settings[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(item['icon'], color: item['color']),
              title: Text(item['title'], style: const TextStyle(fontFamily: 'Changa')),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => item['screen']()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
