import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../services/supabase_service.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});
  @override State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  final _accountController = TextEditingController();
  bool _isLoading = false;
  String? _selectedBank;
  final List<String> _banks = ['البنك الأهلي', 'كاك بنك', 'بنك الكريمي'];

  Future<void> _withdraw() async {
    if (_selectedBank == null || _amountController.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final amount = double.parse(_amountController.text);
      final wallet = await SupabaseService.getWallet();
      if (wallet != null && wallet.yerBalance >= amount) {
        await SupabaseService.updateBalance('yer', wallet.yerBalance - amount);
        await SupabaseService.createTransaction({
          'type': 'withdraw',
          'amount': amount,
          'currency': 'YER',
          'description': 'سحب إلى $_selectedBank',
          'status': 'completed',
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تقديم طلب السحب'), backgroundColor: AppTheme.success));
        Navigator.pop(context);
      } else {
        throw Exception('الرصيد غير كافٍ');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e'), backgroundColor: AppTheme.error));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'سحب'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedBank,
              hint: const Text('اختر البنك'),
              items: _banks.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
              onChanged: (v) => setState(() => _selectedBank = v),
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 16),
            CustomTextField(controller: _accountController, label: 'رقم الحساب / IBAN'),
            const SizedBox(height: 16),
            CustomTextField(controller: _amountController, label: 'المبلغ', prefixIcon: Icons.attach_money, keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            CustomButton(text: 'طلب سحب', onPressed: _withdraw, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
}
