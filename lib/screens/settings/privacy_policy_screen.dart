import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'سياسة الخصوصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'سياسة الخصوصية',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.goldColor,
                ),
              ),
              const SizedBox(height: 24),
              _buildSection('المعلومات التي نجمعها',
                  '• معلومات الحساب: الاسم، رقم الهاتف، البريد الإلكتروني.\n• معلومات الاستخدام: سجل التصفح، الإعلانات المفضلة.\n• معلومات الدفع: لا نخزن بيانات بطاقات الائتمان كاملة.'),
              const SizedBox(height: 20),
              _buildSection('كيف نستخدم معلوماتك',
                  '• لتقديم وتحسين خدماتنا.\n• للتواصل معك بشأن تحديثات وعروض.\n• لضمان أمان المنصة ومنع الاحتيال.'),
              const SizedBox(height: 20),
              _buildSection('مشاركة المعلومات',
                  'لا نشارك معلوماتك الشخصية مع أطراف ثالثة إلا بموافقتك أو للامتثال للقانون.'),
              const SizedBox(height: 20),
              _buildSection('حماية المعلومات',
                  'نستخدم إجراءات أمان مشددة لحماية معلوماتك من الوصول غير المصرح به.'),
              const SizedBox(height: 24),
              const Text(
                'آخر تحديث: 15 مارس 2026',
                style: TextStyle(
                  fontFamily: 'Changa',
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
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
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontFamily: 'Changa',
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
