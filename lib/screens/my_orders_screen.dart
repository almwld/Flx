import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'order_detail_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  final List<Map<String, dynamic>> _orders = const [
    {'id': 'ORD-001', 'date': '15 مارس 2026', 'total': '45,000 ر.ي', 'status': 'جاري التوصيل', 'statusColor': Colors.orange, 'items': 3},
    {'id': 'ORD-002', 'date': '10 مارس 2026', 'total': '128,000 ر.ي', 'status': 'تم التوصيل', 'statusColor': Colors.green, 'items': 2},
    {'id': 'ORD-003', 'date': '5 مارس 2026', 'total': '12,500 ر.ي', 'status': 'ملغي', 'statusColor': Colors.red, 'items': 1},
    {'id': 'ORD-004', 'date': '28 فبراير 2026', 'total': '67,200 ر.ي', 'status': 'تم التوصيل', 'statusColor': Colors.green, 'items': 4},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'طلباتي'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OrderDetailScreen()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'طلب رقم ${order['id']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa'),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (order['statusColor'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          order['status'],
                          style: TextStyle(
                            color: order['statusColor'],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(order['date'], style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamily: 'Changa')),
                      const SizedBox(width: 16),
                      const Icon(Icons.shopping_bag, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${order['items']} منتجات', style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamily: 'Changa')),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الإجمالي',
                        style: TextStyle(fontFamily: 'Changa'),
                      ),
                      Text(
                        order['total'],
                        style: const TextStyle(
                          color: AppTheme.goldColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Changa',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
