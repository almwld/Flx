import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLang = 'ar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'اللغة'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RadioListTile(
            title: const Text('العربية'),
            value: 'ar',
            groupValue: _selectedLang,
            onChanged: (v) => setState(() => _selectedLang = v!),
          ),
          RadioListTile(
            title: const Text('English'),
            value: 'en',
            groupValue: _selectedLang,
            onChanged: (v) => setState(() => _selectedLang = v!),
          ),
        ],
      ),
    );
  }
}
