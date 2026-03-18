import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  final List<Map<String, dynamic>> _methods = const [
    {'name': 'المحفظة', 'icon': Icons.account_balance_wallet, 'balance': '125,000 ر.ي'},
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card, 'last4': '4242'},
    {'name': 'تحويل بنكي', 'icon': Icons.account_balance, 'account': 'YE12 3456'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'طرق الدفع'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _methods.length,
        itemBuilder: (ctx, i) {
          final m = _methods[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(m['icon'] as IconData, color: AppTheme.goldColor),
              title: Text(m['name']),
              subtitle: Text(m.containsKey('balance') ? 'الرصيد: ${m['balance']}' : (m.containsKey('last4') ? '•••• ${m['last4']}' : m['account'])),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
