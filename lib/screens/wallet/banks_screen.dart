import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class BanksScreen extends StatefulWidget {
  const BanksScreen({super.key});

  @override
  State<BanksScreen> createState() => _BanksScreenState();
}

class _BanksScreenState extends State<BanksScreen> {
  final List<Map<String, dynamic>> _banks = [
    {'name': 'البنك الأهلي اليمني', 'icon': Icons.account_balance},
    {'name': 'كاك بنك', 'icon': Icons.account_balance},
    {'name': 'بنك الكريمي', 'icon': Icons.account_balance},
    {'name': 'بنك اليمن والكويت', 'icon': Icons.account_balance},
    {'name': 'البنك الإسلامي', 'icon': Icons.account_balance},
    {'name': 'بنك عدن', 'icon': Icons.account_balance},
  ];

  String? _selectedBank;
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'بنوك'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _banks.length,
              itemBuilder: (ctx, i) {
                final bank = _banks[i];
                final isSelected = _selectedBank == bank['name'];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: isSelected ? AppTheme.goldColor : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(bank['icon'] as IconData, color: isSelected ? Colors.black : AppTheme.goldColor),
                    title: Text(bank['name'], style: TextStyle(color: isSelected ? Colors.black : null)),
                    trailing: isSelected ? const Icon(Icons.check, color: Colors.black) : null,
                    onTap: () => setState(() => _selectedBank = bank['name']),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            if (_selectedBank != null) ...[
              CustomTextField(
                controller: _accountController,
                label: 'رقم الحساب',
                prefixIcon: Icons.numbers,
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
                text: 'تحويل إلى البنك',
                onPressed: (_accountController.text.isEmpty || _amountController.text.isEmpty)
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
