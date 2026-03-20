import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});
  @override State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  Map<String, dynamic>? _order; bool _isLoading = true;

  @override void initState() { super.initState(); _loadOrder(); }
  Future<void> _loadOrder() async {
    await Future.delayed(const Duration(milliseconds: 500)); // محاكاة
    setState(() { _order = {
      'id': widget.orderId, 'created_at': '2026-03-20', 'status': 'processing', 'total_amount': 32000,
      'shipping_address': 'صنعاء - شارع حدة', 'payment_method': 'المحفظة',
      'order_items': [ {'product_title': 'منتج 1', 'quantity': 1, 'price': 15000}, {'product_title': 'منتج 2', 'quantity': 1, 'price': 15000} ]
    }; _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'تفاصيل الطلب'),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            Row(children: [Icon(Icons.check_circle, color: Colors.green), const SizedBox(width: 8), Text('الحالة: قيد المعالجة', style: const TextStyle(fontWeight: FontWeight.bold)) ]),
            const SizedBox(height: 16), LinearProgressIndicator(value: 0.33, backgroundColor: Colors.grey[300], color: AppTheme.goldColor),
            const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('قيد المعالجة'), Text('تم الشحن'), Text('تم التوصيل') ]) ]))),
          const SizedBox(height: 16),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('معلومات التوصيل', style: TextStyle(fontWeight: FontWeight.bold)), const Divider(),
            ListTile(leading: const Icon(Icons.location_on, color: AppTheme.goldColor), title: Text(_order!['shipping_address']), subtitle: const Text('العنوان')),
            ListTile(leading: const Icon(Icons.payment, color: AppTheme.goldColor), title: Text(_order!['payment_method']), subtitle: const Text('طريقة الدفع')) ]))),
          const SizedBox(height: 16),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('المنتجات', style: TextStyle(fontWeight: FontWeight.bold)), const Divider(),
            ...(_order!['order_items'] as List).map((i) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [
              Container(width: 50, height: 50, color: Colors.grey[300], child: const Icon(Icons.image)), const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(i['product_title']), Text('الكمية: ${i['quantity']}', style: const TextStyle(fontSize: 12)) ])),
              Text('${i['price']} ر.ي') ]))),
            const Divider(), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الإجمالي'), Text('${_order!['total_amount']} ر.ي', style: const TextStyle(color: AppTheme.goldColor)) ]) ]))),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.location_on), label: const Text('تتبع الطلب'),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)))),
        ]),
      ),
    );
  }
}
