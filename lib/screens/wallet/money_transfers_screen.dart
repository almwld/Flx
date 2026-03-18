import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class MoneyTransfersScreen extends StatefulWidget {
  const MoneyTransfersScreen({super.key});

  @override
  State<MoneyTransfersScreen> createState() => _MoneyTransfersScreenState();
}

class _MoneyTransfersScreenState extends State<MoneyTransfersScreen> {
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  String? _transferType;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _types = const [
    {'name': 'تحويل إلى مشترك', 'icon': Icons.person_add, 'fee': '0.5%'},
    {'name': 'تحويل بين حساباتي', 'icon': Icons.compare_arrows, 'fee': 'مجاني'},
    {'name': 'حوالات شبكات محلية', 'icon': Icons.device_hub, 'fee': '1%'},
    {'name': 'استلام حوالة', 'icon': Icons.download, 'fee': '0%'},
    {'name': 'تحويل دولي', 'icon': Icons.public, 'fee': '2.5%'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'تحويلات مالية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ..._types.map((t) {
              final isSelected = _transferType == t['name'];
              return GestureDetector(
                onTap: () => setState(() => _transferType = t['name']),
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
                      Icon(t['icon'], color: isSelected ? Colors.black : AppTheme.goldColor, size: 30),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t['name'], style: TextStyle(color: isSelected ? Colors.black : null)),
                            const SizedBox(height: 4),
                            Text('الرسوم: ${t['fee']}', style: TextStyle(fontSize: 12, color: isSelected ? Colors.black87 : Colors.grey)),
                          ],
                        ),
                      ),
                      if (isSelected) const Icon(Icons.check, color: Colors.black),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            if (_transferType != null) ...[
              CustomTextField(
                controller: _recipientController,
                label: 'المستلم (رقم هاتف / حساب)',
                prefixIcon: Icons.person,
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
                text: 'إرسال',
                onPressed: (_recipientController.text.isEmpty || _amountController.text.isEmpty)
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تمت عملية التحويل بنجاح')),
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
