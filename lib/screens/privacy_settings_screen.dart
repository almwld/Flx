import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _showPhone = true;
  bool _showEmail = false;
  bool _showLocation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'إعدادات الخصوصية'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('إظهار رقم الهاتف'),
            value: _showPhone,
            onChanged: (v) => setState(() => _showPhone = v),
            secondary: const Icon(Icons.phone, color: AppTheme.goldColor),
          ),
          SwitchListTile(
            title: const Text('إظهار البريد الإلكتروني'),
            value: _showEmail,
            onChanged: (v) => setState(() => _showEmail = v),
            secondary: const Icon(Icons.email, color: AppTheme.goldColor),
          ),
          SwitchListTile(
            title: const Text('إظهار الموقع'),
            value: _showLocation,
            onChanged: (v) => setState(() => _showLocation = v),
            secondary: const Icon(Icons.location_on, color: AppTheme.goldColor),
          ),
          const Divider(height: 32),
          const Text('من يمكنه رؤية إعلاناتي؟', style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile(
            title: const Text('الجميع'),
            value: 'all',
            groupValue: 'all',
            onChanged: (_) {},
          ),
          RadioListTile(
            title: const Text('المتابعون فقط'),
            value: 'followers',
            groupValue: 'all',
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}
