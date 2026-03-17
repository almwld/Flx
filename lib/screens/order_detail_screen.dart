import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'تفاصيل الطلب'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('رقم الطلب', style: TextStyle(fontFamily: 'Changa')),
                      const Text('ORD-001', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('التاريخ', style: TextStyle(fontFamily: 'Changa')),
                      const Text('15 مارس 2026', style: TextStyle(fontFamily: 'Changa')),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('الحالة', style: TextStyle(fontFamily: 'Changa')),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                        child: const Text('جاري التوصيل', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('المنتجات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
            const SizedBox(height: 12),
            ...List.generate(2, (index) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(width: 60, height: 60, color: Colors.grey[300]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('منتج ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                        const Text('الكمية: 1', style: TextStyle(color: Colors.grey, fontFamily: 'Changa')),
                      ],
                    ),
                  ),
                  const Text('15,000 ر.ي', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                ],
              ),
            )),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('المجموع', style: TextStyle(fontFamily: 'Changa')), const Text('30,000 ر.ي', style: TextStyle(fontFamily: 'Changa'))]),
                  const Divider(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الشحن', style: TextStyle(fontFamily: 'Changa')), const Text('2,000 ر.ي', style: TextStyle(fontFamily: 'Changa'))]),
                  const Divider(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الإجمالي', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa')), const Text('32,000 ر.ي', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontFamily: 'Changa'))]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
