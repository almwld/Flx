import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'عن التطبيق'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.shopping_bag, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text(
              'Flex Yemen Market',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.goldColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'الإصدار 1.0.0',
              style: TextStyle(
                fontFamily: 'Changa',
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoCard(
              title: 'من نحن',
              content: 'فلكس اليمن هي منصة إلكترونية متكاملة تهدف إلى تسهيل عملية البيع والشراء في اليمن. نحن نقدم منصة آمنة وموثوقة للتجار والعملاء.',
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'مميزاتنا',
              content: '• أمان وموثوقية\n• سرعة في التعامل\n• دعم فني 24/7\n• وسائل دفع متعددة',
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'تواصل معنا',
              content: 'support@flexyemen.com\n+967 777 123 456\nصنعاء، اليمن',
            ),
            const SizedBox(height: 32),
            const Text(
              '© 2024 Flex Yemen. جميع الحقوق محفوظة.',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.goldColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'Changa',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
