import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  final _accountController = TextEditingController();
  String? _selectedBank;
  bool _isLoading = false;

  final List<String> _banks = [
    'البنك الأهلي اليمني',
    'كاك بنك',
    'بنك الكريمي',
    'البنك الإسلامي',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final balance = 125000;

    return Scaffold(
      appBar: const CustomAppBar(title: 'سحب'),
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
                  const Text('الرصيد المتاح', style: TextStyle(fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Text('$balance ر.ي', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _selectedBank,
              hint: const Text('اختر البنك'),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: _banks.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
              onChanged: (v) => setState(() => _selectedBank = v),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _accountController,
              label: 'رقم الحساب / IBAN',
              prefixIcon: Icons.numbers,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _amountController,
              label: 'المبلغ',
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'طلب سحب',
              onPressed: (_selectedBank == null || _accountController.text.isEmpty || _amountController.text.isEmpty)
                  ? null
                  : () {
                      setState(() => _isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() => _isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم تقديم طلب السحب بنجاح')),
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
