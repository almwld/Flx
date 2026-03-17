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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الإعدادات'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            context,
            'الإشعارات',
            Icons.notifications,
            Colors.blue,
            const NotificationsSettingsScreen(),
          ),
          _buildMenuItem(
            context,
            'الأمان والخصوصية',
            Icons.security,
            Colors.green,
            const SecuritySettingsScreen(),
          ),
          _buildMenuItem(
            context,
            'اللغة',
            Icons.language,
            Colors.orange,
            const LanguageScreen(),
          ),
          _buildMenuItem(
            context,
            'طرق الدفع',
            Icons.payment,
            Colors.purple,
            const PaymentMethodsScreen(),
          ),
          _buildMenuItem(
            context,
            'المساعدة والدعم',
            Icons.help,
            Colors.teal,
            const HelpSupportScreen(),
          ),
          _buildMenuItem(
            context,
            'عن التطبيق',
            Icons.info,
            Colors.red,
            const AboutScreen(),
          ),
          _buildMenuItem(
            context,
            'سياسة الخصوصية',
            Icons.privacy_tip,
            Colors.indigo,
            const PrivacyPolicyScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
