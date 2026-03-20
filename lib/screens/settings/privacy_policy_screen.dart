import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'سياسة الخصوصية'),
      body: const Padding(padding: EdgeInsets.all(16), child: Text('نحن نلتزم بحماية خصوصيتك...')),
    );
  }
}
