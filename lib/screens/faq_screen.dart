import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});
  final List<Map<String, String>> faqs = const [
    {'q': 'كيف أضيف إعلان؟', 'a': 'من قسم "إضافة إعلان" وملء البيانات'},
    {'q': 'ما طرق الدفع؟', 'a': 'محفظة، بطاقة، تحويل بنكي'},
    {'q': 'كيف أتواصل مع البائع؟', 'a': 'من خاصية المحادثة'},
    {'q': 'هل الإعلانات مجانية؟', 'a': 'الإعلانات العادية مجانية'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الأسئلة الشائعة'),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: faqs.length,
        itemBuilder: (_, i) => Card(margin: const EdgeInsets.only(bottom: 12), child: ExpansionTile(
          title: Text(faqs[i]['q']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          children: [Padding(padding: const EdgeInsets.all(16), child: Text(faqs[i]['a']!)) ]))),
    );
  }
}
