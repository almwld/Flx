import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});
  final List<Map<String, dynamic>> _methods = const [
    {'name': 'المحفظة', 'icon': Icons.account_balance_wallet},
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card},
    {'name': 'تحويل بنكي', 'icon': Icons.account_balance},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'طرق الدفع'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _methods.length,
        itemBuilder: (_, i) {
          final m = _methods[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(m['icon'], color: const Color(0xFFD4AF37)),
              title: Text(m['name']),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
