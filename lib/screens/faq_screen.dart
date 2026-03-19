import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'q': 'كيف يمكنني إضافة إعلان؟',
      'a': 'يمكنك إضافة إعلان من خلال الذهاب إلى قسم "إضافة إعلان" في الشريط السفلي، ثم ملء البيانات المطلوبة وإضافة الصور.'
    },
    {
      'q': 'ما هي طرق الدفع المتاحة؟',
      'a': 'نقبل الدفع عبر المحفظة الإلكترونية، البطاقات الائتمانية (فيزا، ماستركارد)، والتحويل البنكي.'
    },
    {
      'q': 'كيف يمكنني التواصل مع البائع؟',
      'a': 'يمكنك التواصل مع البائع عبر خاصية المحادثة المباشرة من صفحة المنتج، أو الاتصال بهاتفياً إذا كان رقمه ظاهراً.'
    },
    {
      'q': 'هل هناك رسوم على الإعلانات؟',
      'a': 'الإعلانات العادية مجانية تماماً، لكن هناك رسوم رمزية للإعلانات المميزة التي تظهر في أعلى نتائج البحث.'
    },
    {
      'q': 'كم تستغرق عملية الشحن؟',
      'a': 'مدة الشحن تعتمد على موقعك: 1-3 أيام داخل نفس المدينة، 3-7 أيام للمدن الأخرى.'
    },
    {
      'q': 'كيف يمكنني استرداد أموالي؟',
      'a': 'في حالة وجود مشكلة في المنتج، يمكنك طلب استرداد الأموال من خلال صفحة الطلب خلال 7 أيام من الاستلام.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الأسئلة الشائعة'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (ctx, i) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ExpansionTile(
              title: Text(
                faqs[i]['q']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    faqs[i]['a']!,
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
