import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../services/supabase_service.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});
  @override State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final _billController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedService;
  bool _isLoading = false;
  final List<String> _services = ['كهرباء', 'ماء', 'إنترنت', 'هاتف'];

  Future<void> _pay() async {
    if (_selectedService == null || _billController.text.isEmpty || _amountController.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final amount = double.parse(_amountController.text);
      final wallet = await SupabaseService.getWallet();
      if (wallet != null && wallet.yerBalance >= amount) {
        await SupabaseService.updateBalance('yer', wallet.yerBalance - amount);
        await SupabaseService.createTransaction({
          'type': 'payment',
          'amount': amount,
          'currency': 'YER',
          'description': 'دفع فاتورة $_selectedService - رقم ${_billController.text}',
          'status': 'completed',
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الدفع بنجاح'), backgroundColor: AppTheme.success));
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
      appBar: const CustomAppBar(title: 'دفع فواتير'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedService,
              hint: const Text('اختر الخدمة'),
              items: _services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _selectedService = v),
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 16),
            CustomTextField(controller: _billController, label: 'رقم الاشتراك', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            CustomTextField(controller: _amountController, label: 'المبلغ', prefixIcon: Icons.attach_money, keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            CustomButton(text: 'دفع', onPressed: _pay, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
}
