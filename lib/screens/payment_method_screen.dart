import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';

class PaymentMethod {
  final String id;
  final String name;
  final IconData icon;
  final String? subtitle;
  final bool isAvailable;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    this.subtitle,
    this.isAvailable = true,
  });
}

class PaymentMethodScreen extends StatefulWidget {
  final Function(String) onSelect;
  const PaymentMethodScreen({super.key, required this.onSelect});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selectedMethod;
  final List<PaymentMethod> _methods = [
    PaymentMethod(
      id: 'wallet',
      name: 'المحفظة',
      icon: Icons.account_balance_wallet,
      subtitle: 'الرصيد: 125,000 ر.ي',
    ),
    PaymentMethod(
      id: 'card',
      name: 'بطاقة ائتمان',
      icon: Icons.credit_card,
      subtitle: '•••• 4242',
    ),
    PaymentMethod(
      id: 'bank',
      name: 'تحويل بنكي',
      icon: Icons.account_balance,
      subtitle: 'YE12 3456 7890',
    ),
    PaymentMethod(
      id: 'cash',
      name: 'الدفع عند الاستلام',
      icon: Icons.money,
      subtitle: 'رسوم إضافية 1,000 ر.ي',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'طريقة الدفع'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _methods.length,
              itemBuilder: (ctx, i) {
                final m = _methods[i];
                final isSelected = _selectedMethod == m.id;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : null,
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (isSelected ? AppTheme.goldColor : Colors.grey).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(m.icon, color: isSelected ? AppTheme.goldColor : Colors.grey),
                    ),
                    title: Text(m.name),
                    subtitle: m.subtitle != null ? Text(m.subtitle!) : null,
                    trailing: Radio<String>(
                      value: m.id,
                      groupValue: _selectedMethod,
                      onChanged: (v) => setState(() => _selectedMethod = v),
                    ),
                    onTap: () => setState(() => _selectedMethod = m.id),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'تأكيد',
              onPressed: _selectedMethod == null
                  ? null
                  : () {
                      widget.onSelect(_selectedMethod!);
                      Navigator.pop(context);
                    },
            ),
          ),
        ],
      ),
    );
  }
}
