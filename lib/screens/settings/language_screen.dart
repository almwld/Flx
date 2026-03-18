import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'ar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'اللغة'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('العربية'),
                  value: 'ar',
                  groupValue: _selectedLanguage,
                  onChanged: (v) => setState(() => _selectedLanguage = v!),
                  secondary: const Icon(Icons.language, color: AppTheme.goldColor),
                ),
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'en',
                  groupValue: _selectedLanguage,
                  onChanged: (v) => setState(() => _selectedLanguage = v!),
                  secondary: const Icon(Icons.language, color: AppTheme.goldColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
