import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class GovernmentPaymentsScreen extends StatefulWidget {
  const GovernmentPaymentsScreen({super.key});

  @override
  State<GovernmentPaymentsScreen> createState() => _GovernmentPaymentsScreenState();
}

class _GovernmentPaymentsScreenState extends State<GovernmentPaymentsScreen> {
  final _idController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedService;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _services = const [
    {'name': 'المرور', 'icon': Icons.traffic},
    {'name': 'الأحوال المدنية', 'icon': Icons.badge},
    {'name': 'الضرائب', 'icon': Icons.receipt},
    {'name': 'الجوازات', 'icon': Icons.passport},
    {'name': 'البلدية', 'icon': Icons.location_city},
    {'name': 'الكهرباء', 'icon': Icons.electrical_services},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'مدفوعات حكومية'),
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
              children: _services.map((s) {
                final isSelected = _selectedService == s['name'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedService = s['name']),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.goldColor : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(s['icon'], color: isSelected ? Colors.black : AppTheme.goldColor, size: 30),
                        const SizedBox(height: 4),
                        Text(s['name'], style: TextStyle(fontSize: 12, color: isSelected ? Colors.black : null)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (_selectedService != null) ...[
              CustomTextField(
                controller: _idController,
                label: 'رقم الهوية / المعاملة',
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
                text: 'دفع',
                onPressed: (_idController.text.isEmpty || _amountController.text.isEmpty)
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم دفع $_selectedService بقيمة ${_amountController.text} ريال')),
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
