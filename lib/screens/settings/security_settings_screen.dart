import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});
  @override State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _twoFactor = false, _biometric = false, _saveLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الأمان والخصوصية'),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Column(children: [
          SwitchListTile(title: const Text('المصادقة الثنائية'), subtitle: const Text('تعزيز أمان حسابك'), value: _twoFactor, onChanged: (v) => setState(() => _twoFactor = v)),
          const Divider(), SwitchListTile(title: const Text('الدخول بالبصمة'), value: _biometric, onChanged: (v) => setState(() => _biometric = v)),
          const Divider(), SwitchListTile(title: const Text('البقاء متصلاً'), value: _saveLogin, onChanged: (v) => setState(() => _saveLogin = v)) ])) ]));
  }
}
