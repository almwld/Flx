import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final List<Map<String, dynamic>> _universities = const [
    {'name': 'جامعة صنعاء', 'icon': Icons.school},
    {'name': 'جامعة عدن', 'icon': Icons.school},
    {'name': 'جامعة تعز', 'icon': Icons.school},
    {'name': 'جامعة العلوم والتكنولوجيا', 'icon': Icons.science},
    {'name': 'جامعة الأندلس', 'icon': Icons.account_balance},
    {'name': 'جامعة الملكة أروى', 'icon': Icons.account_balance},
  ];

  String? _selectedUniversity;
  final _studentIdController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'تعليم عالي'),
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
              children: _universities.map((u) {
                final isSelected = _selectedUniversity == u['name'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedUniversity = u['name']),
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
                        Icon(u['icon'], color: isSelected ? Colors.black : AppTheme.goldColor, size: 40),
                        const SizedBox(height: 8),
                        Text(
                          u['name'],
                          style: TextStyle(color: isSelected ? Colors.black : null),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (_selectedUniversity != null) ...[
              CustomTextField(
                controller: _studentIdController,
                label: 'الرقم الجامعي',
                prefixIcon: Icons.badge,
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
                text: 'دفع الرسوم',
                onPressed: (_studentIdController.text.isEmpty || _amountController.text.isEmpty)
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم دفع رسوم $_selectedUniversity بقيمة ${_amountController.text} ريال')),
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
