import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class CashWithdrawalScreen extends StatefulWidget {
  const CashWithdrawalScreen({super.key});

  @override
  State<CashWithdrawalScreen> createState() => _CashWithdrawalScreenState();
}

class _CashWithdrawalScreenState extends State<CashWithdrawalScreen> {
  final _amountController = TextEditingController();
  final _locationController = TextEditingController();
  bool _isLoading = false;

  final List<String> _locations = [
    'صنعاء - شارع حدة',
    'عدن - خور مكسر',
    'تعز - جولة القصر',
    'الحديدة - شارع صنعاء',
  ];

  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final balance = 125000;

    return Scaffold(
      appBar: const CustomAppBar(title: 'سحب نقدي'),
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
              value: _selectedLocation,
              hint: const Text('اختر موقع الاستلام'),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: _locations.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
              onChanged: (v) => setState(() => _selectedLocation = v),
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
              text: 'طلب سحب نقدي',
              onPressed: (_selectedLocation == null || _amountController.text.isEmpty)
                  ? null
                  : () {
                      setState(() => _isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() => _isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم تقديم طلب السحب النقدي، استلم المبلغ من $_selectedLocation')),
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
