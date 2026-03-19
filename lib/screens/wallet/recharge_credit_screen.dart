import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class RechargeCreditScreen extends StatefulWidget {
  const RechargeCreditScreen({super.key});

  @override
  State<RechargeCreditScreen> createState() => _RechargeCreditScreenState();
}

class _RechargeCreditScreenState extends State<RechargeCreditScreen> {
  final _numberController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  final List<Map<String, dynamic>> _operators = const [
    {'name': 'سبأفون', 'icon': Icons.signal_cellular_alt},
    {'name': 'يمن موبايل', 'icon': Icons.signal_cellular_alt},
    {'name': 'إم تي إن', 'icon': Icons.signal_cellular_alt},
  ];

  String? _selectedOperator;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final balance = 125000;

    return Scaffold(
      appBar: const CustomAppBar(title: 'شحن الرصيد'),
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
            ..._operators.map((op) {
              final isSelected = _selectedOperator == op['name'];
              return GestureDetector(
                onTap: () => setState(() => _selectedOperator = op['name']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.goldColor : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(op['icon'], color: isSelected ? Colors.black : AppTheme.goldColor, size: 30),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          op['name'],
                          style: TextStyle(color: isSelected ? Colors.black : null, fontSize: 16),
                        ),
                      ),
                      if (isSelected) const Icon(Icons.check, color: Colors.black),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _numberController,
              label: 'رقم الهاتف',
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
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
              text: 'شحن',
              onPressed: (_selectedOperator == null || _numberController.text.isEmpty || _amountController.text.isEmpty)
                  ? null
                  : () {
                      setState(() => _isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() => _isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم شحن رصيد بقيمة ${_amountController.text} ريال لرقم ${_numberController.text}')),
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
