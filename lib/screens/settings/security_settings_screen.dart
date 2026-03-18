import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _twoFactor = false;
  bool _biometric = false;
  bool _saveLogin = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الأمان والخصوصية'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('المصادقة الثنائية'),
                  subtitle: const Text('تعزيز أمان حسابك'),
                  value: _twoFactor,
                  onChanged: (v) => setState(() => _twoFactor = v),
                  secondary: const Icon(Icons.lock, color: AppTheme.goldColor),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  title: const Text('الدخول بالبصمة / Face ID'),
                  value: _biometric,
                  onChanged: (v) => setState(() => _biometric = v),
                  secondary: const Icon(Icons.fingerprint, color: AppTheme.goldColor),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  title: const Text('البقاء متصلاً'),
                  value: _saveLogin,
                  onChanged: (v) => setState(() => _saveLogin = v),
                  secondary: const Icon(Icons.save, color: AppTheme.goldColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('تغيير كلمة المرور'),
            leading: const Icon(Icons.password, color: AppTheme.goldColor),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
