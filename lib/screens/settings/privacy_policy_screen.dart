import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'سياسة الخصوصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'آخر تحديث: 19 مارس 2026',
              style: TextStyle(color: Colors.grey, fontFamily: 'Changa'),
            ),
            const SizedBox(height: 16),
            const Text(
              'نحن في Flex Yemen نلتزم بحماية خصوصيتك. توضح هذه السياسة كيفية جمع واستخدام وحماية معلوماتك الشخصية.',
              style: TextStyle(fontFamily: 'Changa', height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'المعلومات التي نجمعها:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
            ),
            const SizedBox(height: 8),
            const Text(
              '• الاسم، البريد الإلكتروني، رقم الهاتف\n• معلومات الدفع (نحن لا نخزن تفاصيل البطاقة)\n• بيانات الموقع (اختياري)\n• سجل التصفح والإعلانات',
              style: TextStyle(fontFamily: 'Changa', height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'كيف نستخدم معلوماتك:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
            ),
            const SizedBox(height: 8),
            const Text(
              '• لتقديم الخدمات وتحسين تجربتك\n• للتواصل معك بشأن طلباتك\n• لإرسال العروض (يمكنك إلغاء الاشتراك)\n• لتحسين أمان التطبيق',
              style: TextStyle(fontFamily: 'Changa', height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
