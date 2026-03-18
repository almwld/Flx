import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الشروط والأحكام'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'مرحباً بك في Flex Yemen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
            ),
            const SizedBox(height: 16),
            const Text(
              '1. قبول الشروط\nباستخدامك لهذا التطبيق، فإنك توافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، يرجى عدم استخدام التطبيق.',
              style: TextStyle(fontFamily: 'Changa', height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              '2. الحساب\nيجب أن تكون مسجلاً للاستفادة من معظم الخدمات. أنت مسؤول عن الحفاظ على سرية معلومات حسابك وكلمة المرور.',
              style: TextStyle(fontFamily: 'Changa', height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              '3. الإعلانات\nيمكنك إضافة إعلانات مجانية، لكن يجب أن تتوافق مع القوانين المحلية وأخلاقيات التجارة. نحن غير مسؤولين عن محتوى الإعلانات المضافة من قبل المستخدمين.',
              style: TextStyle(fontFamily: 'Changa', height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              '4. الدفع والمعاملات\nالمعاملات المالية تتم عبر المحفظة الإلكترونية أو طرق الدفع المتاحة. نحن لا نخزن معلومات بطاقات الدفع الخاصة بك.',
              style: TextStyle(fontFamily: 'Changa', height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              '5. الخصوصية\nنحن نحترم خصوصيتك، ولمزيد من المعلومات يرجى الاطلاع على سياسة الخصوصية الخاصة بنا.',
              style: TextStyle(fontFamily: 'Changa', height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
