import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'order_detail_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Map<String, dynamic>> _orders = [
    {'id': 'ORD-001', 'date': '15 مارس 2026', 'items': ['آيفون 14 برو ماكس', 'سماعة AirPods'], 'total': '850,000', 'status': 'completed', 'statusText': 'مكتمل'},
    {'id': 'ORD-002', 'date': '10 مارس 2026', 'items': ['سامسونج S24 الترا'], 'total': '380,000', 'status': 'shipped', 'statusText': 'تم الشحن'},
    {'id': 'ORD-003', 'date': '5 مارس 2026', 'items': ['لابتوب لينوفو'], 'total': '720,000', 'status': 'processing', 'statusText': 'قيد المعالجة'},
    {'id': 'ORD-004', 'date': '28 فبراير 2026', 'items': ['سماعة سوني'], 'total': '95,000', 'status': 'delivered', 'statusText': 'تم التوصيل'},
    {'id': 'ORD-005', 'date': '20 فبراير 2026', 'items': ['ساعة أبل'], 'total': '250,000', 'status': 'cancelled', 'statusText': 'ملغي'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي', style: TextStyle(fontFamily: 'Changa')),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'قيد المعالجة'),
            Tab(text: 'تم الشحن'),
            Tab(text: 'مكتملة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(_orders, isDark),
          _buildOrderList(_orders.where((o) => o['status'] == 'processing').toList(), isDark),
          _buildOrderList(_orders.where((o) => o['status'] == 'shipped').toList(), isDark),
          _buildOrderList(_orders.where((o) => o['status'] == 'completed' || o['status'] == 'delivered').toList(), isDark),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders, bool isDark) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('لا توجد طلبات في هذا القسم', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: order['id'])),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('طلب رقم: ${order['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order['status']).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          order['statusText'],
                          style: TextStyle(color: _getStatusColor(order['status']), fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('تاريخ الطلب: ${order['date']}', style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Text('المنتجات: ${order['items'].join('، ')}'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('الإجمالي: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${order['total']} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('تتبع الطلب', style: TextStyle(color: AppTheme.goldColor)),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text('إعادة الشراء', style: TextStyle(color: AppTheme.goldColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
