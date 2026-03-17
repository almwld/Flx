import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricEnabled = true;
  bool _twoFactorEnabled = false;
  bool _loginNotifications = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الأمان والخصوصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('كلمة المرور'),
            _buildCard(
              child: ListTile(
                leading: const Icon(Icons.lock, color: AppTheme.goldColor),
                title: const Text('تغيير كلمة المرور'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showChangePasswordDialog(context);
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('المصادقة'),
            _buildCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('البصمة / Face ID'),
                    value: _biometricEnabled,
                    onChanged: (value) => setState(() => _biometricEnabled = value),
                    secondary: const Icon(Icons.fingerprint, color: AppTheme.goldColor),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('التحقق بخطوتين'),
                    value: _twoFactorEnabled,
                    onChanged: (value) => setState(() => _twoFactorEnabled = value),
                    secondary: const Icon(Icons.security, color: AppTheme.goldColor),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('إشعارات تسجيل الدخول'),
                    value: _loginNotifications,
                    onChanged: (value) => setState(() => _loginNotifications = value),
                    secondary: const Icon(Icons.notifications, color: AppTheme.goldColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('الأجهزة المتصلة'),
            _buildCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone_android, color: AppTheme.goldColor),
                    title: const Text('هاتفي الحالي'),
                    subtitle: const Text('نشط الآن'),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.laptop, color: AppTheme.goldColor),
                    title: const Text('جهاز آخر'),
                    subtitle: const Text('تعز، اليمن • قبل ساعتين'),
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('إنهاء', style: TextStyle(color: AppTheme.error)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تغيير كلمة المرور', style: TextStyle(fontFamily: 'Changa')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'كلمة المرور الحالية'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'كلمة المرور الجديدة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تغيير كلمة المرور')),
              );
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.goldColor,
          fontFamily: 'Changa',
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
