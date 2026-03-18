import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {'q': 'كيف يمكنني إضافة إعلان؟', 'a': 'يمكنك إضافة إعلان من خلال الذهاب إلى قسم "إضافة إعلان" وملء البيانات المطلوبة.'},
    {'q': 'ما هي طرق الدفع المتاحة؟', 'a': 'نقبل الدفع عبر المحفظة الإلكترونية، البطاقات الائتمانية، والتحويل البنكي.'},
    {'q': 'كيف يمكنني التواصل مع البائع؟', 'a': 'يمكنك التواصل مع البائع عبر خاصية المحادثة المباشرة أو الاتصال بهاتفياً.'},
    {'q': 'هل هناك رسوم على الإعلانات؟', 'a': 'الإعلانات العادية مجانية، لكن هناك رسوم رمزية للإعلانات المميزة.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الأسئلة الشائعة', style: TextStyle(fontFamily: 'Changa'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (ctx, i) {
          return Card(
            child: ExpansionTile(
              title: Text(faqs[i]['q']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(faqs[i]['a']!, style: const TextStyle(fontFamily: 'Changa')),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
