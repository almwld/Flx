import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

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
            // حالة الطلب
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text('تم تأكيد الطلب', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text('رقم: $orderId'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: 0.3,
                      backgroundColor: Colors.grey[300],
                      color: AppTheme.goldColor,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('قيد المعالجة', style: TextStyle(fontSize: 12)),
                        Text('تم الشحن', style: TextStyle(fontSize: 12)),
                        Text('تم التوصيل', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // معلومات التوصيل
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('معلومات التوصيل', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person, color: AppTheme.goldColor),
                      title: const Text('محمد أحمد'),
                      subtitle: const Text('المستلم'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: AppTheme.goldColor),
                      title: const Text('صنعاء - شارع حدة'),
                      subtitle: const Text('العنوان'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone, color: AppTheme.goldColor),
                      title: const Text('777123456'),
                      subtitle: const Text('رقم الهاتف'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // المنتجات
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('المنتجات', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Divider(),
                    ...List.generate(2, (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('منتج ${i + 1}'),
                                Text('الكمية: 1', style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          const Text('15,000 ر.ي'),
                        ],
                      ),
                    )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('الإجمالي'),
                        Text('32,000 ر.ي', style: TextStyle(color: AppTheme.goldColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // زر تتبع الطلب
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                label: const Text('تتبع الطلب'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
