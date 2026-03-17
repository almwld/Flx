import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _methods = [
    {'type': 'wallet', 'name': 'المحفظة', 'balance': '125,000 ر.ي', 'icon': Icons.account_balance_wallet, 'color': Colors.amber},
    {'type': 'card', 'name': 'فيزا **** 4242', 'expiry': '12/25', 'icon': Icons.credit_card, 'color': Colors.blue},
    {'type': 'card', 'name': 'ماستركارد **** 8888', 'expiry': '08/24', 'icon': Icons.credit_card, 'color': Colors.red},
    {'type': 'bank', 'name': 'البنك الأهلي', 'account': 'YE12 3456 7890', 'icon': Icons.account_balance, 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'طرق الدفع',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _methods.length,
        itemBuilder: (context, index) {
          final method = _methods[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (method['color'] as Color).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(method['icon'] as IconData, color: method['color']),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(method['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (method.containsKey('balance'))
                        Text('الرصيد: ${method['balance']}', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      if (method.containsKey('expiry'))
                        Text('تنتهي: ${method['expiry']}', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      if (method.containsKey('account'))
                        Text(method['account'], style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                    const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(color: Colors.red))),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
