import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class JibScreen extends StatefulWidget {
  const JibScreen({super.key});

  @override
  State<JibScreen> createState() => _JibScreenState();
}

class _JibScreenState extends State<JibScreen> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final balance = 125000;

    return Scaffold(
      appBar: const CustomAppBar(title: 'جيب'),
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
                  const Text('الرصيد', style: TextStyle(fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Text('$balance ر.ي', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _phoneController,
              label: 'رقم الهاتف (المستلم)',
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
            const SizedBox(height: 16),
            CustomTextField(
              controller: _pinController,
              label: 'رمز الحماية',
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'إرسال',
              onPressed: (_phoneController.text.isEmpty || _amountController.text.isEmpty || _pinController.text.isEmpty)
                  ? null
                  : () {
                      setState(() => _isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() => _isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم إرسال المبلغ إلى ${_phoneController.text}')),
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
