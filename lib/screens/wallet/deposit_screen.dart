import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../services/supabase_service.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});
  @override State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController();
  bool _isLoading = false;
  String? _selectedMethod;

  final List<Map<String, dynamic>> _methods = [
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card, 'fee': '2%'},
    {'name': 'تحويل بنكي', 'icon': Icons.account_balance, 'fee': '0.5%'},
    {'name': 'كاش', 'icon': Icons.money, 'fee': '0%'},
  ];

  Future<void> _deposit() async {
    if (_selectedMethod == null || _amountController.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final amount = double.parse(_amountController.text);
      final wallet = await SupabaseService.getWallet();
      if (wallet != null) {
        final newBalance = (wallet['yer_balance'] as num).toDouble() + amount;
        await SupabaseService.updateBalance('yer', newBalance);
        await SupabaseService.createTransaction({
          'type': 'deposit',
          'amount': amount,
          'currency': 'YER',
          'description': 'إيداع عبر ${_selectedMethod}',
          'status': 'completed',
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم الإيداع بنجاح'), backgroundColor: AppTheme.success),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e'), backgroundColor: AppTheme.error),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'إيداع'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: _amountController,
              label: 'المبلغ',
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedMethod,
              hint: const Text('طريقة الدفع'),
              items: _methods.map((m) => DropdownMenuItem(
                value: m['name'],
                child: Row(
                  children: [Icon(m['icon']), const SizedBox(width: 8), Text('${m['name']} (رسوم ${m['fee']})')],
                ),
              )).toList(),
              onChanged: (v) => setState(() => _selectedMethod = v),
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'إيداع',
              onPressed: _deposit,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
