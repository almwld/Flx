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

  Future<void> _deposit() async {
    if (_amountController.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final amount = double.parse(_amountController.text);
      final wallet = await SupabaseService.getWallet();
      if (wallet != null) {
        await SupabaseService.updateBalance('yer', wallet.yerBalance + amount);
        await SupabaseService.createTransaction({
          'type': 'deposit',
          'amount': amount,
          'currency': 'YER',
          'description': 'إيداع',
          'status': 'completed',
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الإيداع بنجاح'), backgroundColor: AppTheme.success));
        Navigator.pop(context);
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
      appBar: const CustomAppBar(title: 'إيداع'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(controller: _amountController, label: 'المبلغ', prefixIcon: Icons.attach_money, keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            CustomButton(text: 'إيداع', onPressed: _deposit, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
}
