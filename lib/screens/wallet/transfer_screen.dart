import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../services/supabase_service.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});
  @override State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  Future<void> _transfer() async {
    if (_phoneController.text.isEmpty || _amountController.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final amount = double.parse(_amountController.text);
      final wallet = await SupabaseService.getWallet();
      if (wallet != null && wallet.yerBalance >= amount) {
        await SupabaseService.updateBalance('yer', wallet.yerBalance - amount);
        await SupabaseService.createTransaction({
          'type': 'transfer',
          'amount': amount,
          'currency': 'YER',
          'description': 'تحويل إلى ${_phoneController.text}',
          'status': 'completed',
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم التحويل بنجاح'), backgroundColor: AppTheme.success));
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
      appBar: const CustomAppBar(title: 'تحويل'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(controller: _phoneController, label: 'رقم المستلم', prefixIcon: Icons.phone, keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            CustomTextField(controller: _amountController, label: 'المبلغ', prefixIcon: Icons.attach_money, keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            CustomButton(text: 'تحويل', onPressed: _transfer, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
}
