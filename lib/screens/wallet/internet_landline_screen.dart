import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class InternetLandlineScreen extends StatefulWidget {
  const InternetLandlineScreen({super.key});

  @override
  State<InternetLandlineScreen> createState() => _InternetLandlineScreenState();
}

class _InternetLandlineScreenState extends State<InternetLandlineScreen> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedProvider;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _providers = const [
    {'name': 'يمن نت', 'icon': Icons.wifi, 'prices': ['5,000', '10,000', '15,000']},
    {'name': 'عدن نت', 'icon': Icons.wifi, 'prices': ['4,500', '9,000', '13,000']},
    {'name': 'سبأ نت', 'icon': Icons.wifi, 'prices': ['6,000', '11,000', '16,000']},
    {'name': 'تيليمن', 'icon': Icons.phone, 'prices': ['3,000', '6,000', '9,000']},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'إنترنت وهاتف أرضي'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: _providers.map((p) {
                final isSelected = _selectedProvider == p['name'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedProvider = p['name']),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.goldColor : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(p['icon'], color: isSelected ? Colors.black : AppTheme.goldColor, size: 40),
                        const SizedBox(height: 8),
                        Text(p['name'], style: TextStyle(color: isSelected ? Colors.black : null)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (_selectedProvider != null) ...[
              CustomTextField(
                controller: _phoneController,
                label: 'رقم الهاتف / الاشتراك',
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
                text: 'دفع',
                onPressed: (_phoneController.text.isEmpty || _amountController.text.isEmpty)
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم دفع فاتورة $_selectedProvider بقيمة ${_amountController.text} ريال')),
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
