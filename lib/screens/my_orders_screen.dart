import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';
import 'order_detail_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});
  @override State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; List<Map<String, dynamic>> _orders = []; bool _isLoading = true;

  @override void initState() { super.initState(); _tabController = TabController(length: 4, vsync: this); _loadOrders(); }
  Future<void> _loadOrders() async { _orders = await SupabaseService.getUserOrders(); setState(() => _isLoading = false); }

  String _statusText(s) => s == 'pending' ? 'قيد الانتظار' : s == 'processing' ? 'قيد المعالجة' : s == 'shipped' ? 'تم الشحن' : s == 'delivered' ? 'تم التوصيل' : s;
  Color _statusColor(s) => s == 'delivered' ? Colors.green : s == 'shipped' ? Colors.blue : s == 'processing' ? Colors.orange : s == 'pending' ? Colors.grey : Colors.red;

  List<Map<String, dynamic>> _filter(String status) {
    if (status == 'الكل') return _orders;
    return _orders.where((o) => o['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('طلباتي'), bottom: TabBar(controller: _tabController, isScrollable: true,
        tabs: const [Tab(text: 'الكل'), Tab(text: 'قيد الانتظار'), Tab(text: 'تم الشحن'), Tab(text: 'مكتملة')])),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : TabBarView(controller: _tabController, children: [
        _buildList(_filter('الكل')), _buildList(_filter('pending')), _buildList(_filter('shipped')), _buildList(_filter('delivered')) ]),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]), const SizedBox(height: 16), Text('لا توجد طلبات') ]));
    return ListView.builder(padding: const EdgeInsets.all(12), itemCount: orders.length,
      itemBuilder: (_, i) { final o = orders[i];
        return Card(margin: const EdgeInsets.only(bottom: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: o['id']))),
            child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [ Text('طلب رقم: ${o['id']}', style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: _statusColor(o['status']).withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: Text(_statusText(o['status']), style: TextStyle(color: _statusColor(o['status']), fontSize: 12))) ]),
              const SizedBox(height: 8), Text('التاريخ: ${o['created_at']?.toString().substring(0, 10)}'),
              const SizedBox(height: 8), Text('المنتجات: ${o['order_items']?.length ?? 0} منتج'),
              const SizedBox(height: 8), Row(children: [const Text('الإجمالي: '), Text('${o['total_amount'] ?? 0} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)) ])
            ])))); });
  }
}
