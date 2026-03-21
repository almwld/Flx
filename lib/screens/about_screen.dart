import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'عن التطبيق'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.shopping_bag, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text('Flex Yemen', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('الإصدار 1.0.0', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            const Text(
              'منصة تجارة إلكترونية يمنية متكاملة تهدف إلى تسهيل البيع والشراء وتوفير خدمات مالية متنوعة.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: const Icon(Icons.code, color: AppTheme.goldColor),
              title: const Text('المطور'),
              subtitle: const Text('فريق Flex Yemen'),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppTheme.goldColor),
              title: const Text('البريد الإلكتروني'),
              subtitle: const Text('support@flexyemen.com'),
            ),
            ListTile(
              leading: const Icon(Icons.web, color: AppTheme.goldColor),
              title: const Text('الموقع الإلكتروني'),
              subtitle: const Text('www.flexyemen.com'),
            ),
          ],
        ),
      ),
    );
  }
}
