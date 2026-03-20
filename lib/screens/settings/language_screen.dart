import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _lang = 'ar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'اللغة'),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Column(children: [
          RadioListTile<String>(title: const Text('العربية'), value: 'ar', groupValue: _lang, onChanged: (v) => setState(() => _lang = v!)),
          RadioListTile<String>(title: const Text('English'), value: 'en', groupValue: _lang, onChanged: (v) => setState(() => _lang = v!)) ])) ]));
  }
}
