import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class BanksWalletsScreen extends StatefulWidget {
  const BanksWalletsScreen({super.key});

  @override
  State<BanksWalletsScreen> createState() => _BanksWalletsScreenState();
}

class _BanksWalletsScreenState extends State<BanksWalletsScreen> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'البنك الأهلي', 'icon': Icons.account_balance, 'type': 'بنك'},
    {'name': 'كاك بنك', 'icon': Icons.account_balance, 'type': 'بنك'},
    {'name': 'كريمي', 'icon': Icons.wallet, 'type': 'محفظة'},
    {'name': 'فلكس باي', 'icon': Icons.wallet, 'type': 'محفظة'},
    {'name': 'أموال', 'icon': Icons.wallet, 'type': 'محفظة'},
    {'name': 'بنك اليمن والكويت', 'icon': Icons.account_balance, 'type': 'بنك'},
  ];

  String? _selectedItem;
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'بنوك ومحافظ'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              itemBuilder: (ctx, i) {
                final item = _items[i];
                final isSelected = _selectedItem == item['name'];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: isSelected ? AppTheme.goldColor : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(item['icon'] as IconData, color: isSelected ? Colors.black : AppTheme.goldColor),
                    title: Text(item['name'], style: TextStyle(color: isSelected ? Colors.black : null)),
                    subtitle: Text(item['type'], style: TextStyle(color: isSelected ? Colors.black87 : Colors.grey)),
                    trailing: isSelected ? const Icon(Icons.check, color: Colors.black) : null,
                    onTap: () => setState(() => _selectedItem = item['name']),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            if (_selectedItem != null) ...[
              CustomTextField(
                controller: _accountController,
                label: 'رقم الحساب / المحفظة',
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
                text: 'تحويل',
                onPressed: (_accountController.text.isEmpty || _amountController.text.isEmpty)
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم التحويل إلى $_selectedItem بنجاح')),
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
