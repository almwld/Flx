import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/simple_app_bar.dart';

/// شاشة الإيداع
class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController();
  String _selectedCurrency = 'YER';
  String _selectedMethod = 'كريمي';
  bool _isLoading = false;

  final List<String> _currencies = ['YER', 'SAR', 'USD'];
  final List<String> _methods = ['كريمي', 'بنكي', 'تحويل', 'فودافون كاش'];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _deposit() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال المبلغ', style: TextStyle(fontFamily: 'Changa')),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // محاكاة عملية الإيداع
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال طلب الإيداع بنجاح', style: TextStyle(fontFamily: 'Changa')),
          backgroundColor: AppTheme.success,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إيداع'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الرصيد
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الرصيد الحالي',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 14,
                      color: AppTheme.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '125,000 ر.ي',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // اختيار العملة
            Text(
              'العملة',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: _currencies.map((currency) {
                final isSelected = _selectedCurrency == currency;
                return ChoiceChip(
                  label: Text(
                    currency,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: isSelected ? AppTheme.darkText : AppTheme.getTextColor(context),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: AppTheme.goldColor,
                  backgroundColor: AppTheme.getCardColor(context),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedCurrency = currency);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // المبلغ
            Text(
              'المبلغ',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: const TextStyle(fontFamily: 'Changa'),
              decoration: InputDecoration(
                hintText: 'أدخل المبلغ',
                filled: true,
                fillColor: AppTheme.getCardColor(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.goldColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'ر.ي',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: AppTheme.goldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // طريقة الدفع
            Text(
              'طريقة الدفع',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 12),
            ..._methods.map((method) {
              return RadioListTile<String>(
                title: Text(
                  method,
                  style: const TextStyle(fontFamily: 'Changa'),
                ),
                value: method,
                groupValue: _selectedMethod,
                activeColor: AppTheme.goldColor,
                onChanged: (value) {
                  setState(() => _selectedMethod = value!);
                },
              );
            }).toList(),
            const SizedBox(height: 32),
            // زر الإيداع
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
