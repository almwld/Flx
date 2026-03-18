import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController();
  String? _selectedMethod;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card, 'fee': '2%'},
    {'name': 'تحويل بنكي', 'icon': Icons.account_balance, 'fee': '0.5%'},
    {'name': 'كريمي', 'icon': Icons.wallet, 'fee': '1%'},
    {'name': 'كاش', 'icon': Icons.money, 'fee': '0%'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final balance = 125000; // تجريبي

    return Scaffold(
      appBar: const CustomAppBar(title: 'إيداع'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('الرصيد الحالي', style: TextStyle(fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Text('$balance ر.ي', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _amountController,
              label: 'المبلغ',
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedMethod,
              hint: const Text('اختر طريقة الدفع'),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: _paymentMethods.map((m) {
                return DropdownMenuItem(
                  value: m['name'],
                  child: Row(
                    children: [
                      Icon(m['icon'], color: AppTheme.goldColor, size: 20),
                      const SizedBox(width: 8),
                      Text('${m['name']} (رسوم ${m['fee']})'),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (v) => setState(() => _selectedMethod = v),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'إيداع',
              onPressed: _selectedMethod == null || _amountController.text.isEmpty
                  ? null
                  : () {
                      setState(() => _isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() => _isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تمت عملية الإيداع بنجاح')),
                        );
                        Navigator.pop(context);
                      });
                    },
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
