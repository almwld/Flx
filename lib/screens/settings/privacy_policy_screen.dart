import 'package:flutter/material.dart';
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
            const Text('آخر تحديث: 21 مارس 2026', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            const Text('نحن في Flex Yemen نلتزم بحماية خصوصيتك. توضح هذه السياسة كيفية جمع واستخدام وحماية معلوماتك الشخصية.'),
            const SizedBox(height: 16),
            const Text('المعلومات التي نجمعها:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('• الاسم، البريد الإلكتروني، رقم الهاتف\n• معلومات الدفع (نحن لا نخزن تفاصيل البطاقة)\n• بيانات الموقع (اختياري)\n• سجل التصفح والإعلانات'),
            const SizedBox(height: 16),
            const Text('كيف نستخدم معلوماتك:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('• لتقديم الخدمات وتحسين تجربتك\n• للتواصل معك بشأن طلباتك\n• لإرسال العروض (يمكنك إلغاء الاشتراك)\n• لتحسين أمان التطبيق'),
            const SizedBox(height: 16),
            const Text('مشاركة المعلومات:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('نحن لا نبيع أو نشارك معلوماتك الشخصية مع أطراف ثالثة، إلا عند الضرورة لتقديم الخدمات (مثل شركات الشحن) أو بموجب القانون.'),
          ],
        ),
      ),
    );
  }
}
