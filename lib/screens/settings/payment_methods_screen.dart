import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});
  @override State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _methods = [
    {'name': 'المحفظة', 'icon': Icons.account_balance_wallet, 'balance': '125,000 ر.ي', 'selected': true},
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card, 'last4': '4242', 'selected': false},
    {'name': 'تحويل بنكي', 'icon': Icons.account_balance, 'account': 'YE12 3456 7890', 'selected': false},
  ];

  void _addNewCard() {
    // فتح صفحة إضافة بطاقة جديدة
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'طرق الدفع'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _methods.length,
              itemBuilder: (_, i) {
                final m = _methods[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: Icon(m['icon'] as IconData, color: AppTheme.goldColor),
                    title: Text(m['name']),
                    subtitle: Text(
                      m.containsKey('balance')
                          ? 'الرصيد: ${m['balance']}'
                          : (m.containsKey('last4')
                              ? '•••• ${m['last4']}'
                              : m['account'] as String),
                    ),
                    trailing: m['selected'] == true
                        ? const Icon(Icons.check_circle, color: AppTheme.goldColor)
                        : IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                    onTap: () {
                      setState(() {
                        for (var method in _methods) {
                          method['selected'] = false;
                        }
                        m['selected'] = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم اختيار ${m['name']} كطريقة دفع افتراضية')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'إضافة بطاقة جديدة',
              onPressed: _addNewCard,
              isOutlined: true,
            ),
          ),
        ],
      ),
    );
  }
}
