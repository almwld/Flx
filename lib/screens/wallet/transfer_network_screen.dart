import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class TransferNetworkScreen extends StatefulWidget {
  const TransferNetworkScreen({super.key});

  @override
  State<TransferNetworkScreen> createState() => _TransferNetworkScreenState();
}

class _TransferNetworkScreenState extends State<TransferNetworkScreen> {
  String? _selectedNetwork;
  final _amountController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isLoading = false;

  final List<String> _networks = [
    'ويسترن يونيون',
    'موني غرام',
    'حوالة',
    'كاش يو',
    'ريت',
    'إكسبرس',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'شبكة تحويل'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: _networks.map((n) {
                final isSelected = _selectedNetwork == n;
                return GestureDetector(
                  onTap: () => setState(() => _selectedNetwork = n),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.goldColor : (Theme.of(context).brightness == Brightness.dark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_ethernet, color: isSelected ? Colors.black : AppTheme.goldColor, size: 30),
                        const SizedBox(height: 4),
                        Text(n, style: TextStyle(fontSize: 12, color: isSelected ? Colors.black : null), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (_selectedNetwork != null) ...[
              CustomTextField(
                controller: _amountController,
                label: 'المبلغ',
                prefixIcon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _codeController,
                label: 'رمز التحويل',
                prefixIcon: Icons.qr_code,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'إرسال',
                onPressed: (_amountController.text.isEmpty || _codeController.text.isEmpty)
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم إرسال الحوالة بنجاح')),
                          );
                          Navigator.pop(context);
                        });
                      },
                isLoading: _isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
