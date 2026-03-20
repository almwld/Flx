import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLang = 'ar';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'اللغة'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text('العربية', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('Arabic'),
                        value: 'ar',
                        groupValue: _selectedLang,
                        onChanged: (v) => setState(() => _selectedLang = v!),
                        secondary: const Icon(Icons.language, color: AppTheme.goldColor),
                      ),
                      const Divider(),
                      RadioListTile<String>(
                        title: const Text('English', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('الإنجليزية'),
                        value: 'en',
                        groupValue: _selectedLang,
                        onChanged: (v) => setState(() => _selectedLang = v!),
                        secondary: const Icon(Icons.language, color: AppTheme.goldColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'حفظ',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تغيير اللغة بنجاح')),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
