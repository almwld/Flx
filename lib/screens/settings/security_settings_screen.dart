import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});
  @override State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _twoFactor = false;
  bool _biometric = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الأمان والخصوصية'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('المصادقة الثنائية'),
            value: _twoFactor,
            onChanged: (v) => setState(() => _twoFactor = v),
          ),
          SwitchListTile(
            title: const Text('الدخول بالبصمة'),
            value: _biometric,
            onChanged: (v) => setState(() => _biometric = v),
          ),
        ],
      ),
    );
  }
}
