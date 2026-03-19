import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final _billNumberController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedService;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _services = [
    {'name': 'كهرباء', 'icon': Icons.electrical_services},
    {'name': 'ماء', 'icon': Icons.water_drop},
    {'name': 'إنترنت', 'icon': Icons.wifi},
    {'name': 'هاتف', 'icon': Icons.phone},
    {'name': 'تلفزيون', 'icon': Icons.tv},
    {'name': 'غاز', 'icon': Icons.fire_extinguisher},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final balance = 125000;

    return Scaffold(
      appBar: const CustomAppBar(title: 'دفع فواتير'),
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
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: _services.map((s) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedService = s['name']),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedService == s['name']
                          ? AppTheme.goldColor
                          : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedService == s['name']
                            ? Colors.transparent
                            : AppTheme.goldColor.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(s['icon'], color: _selectedService == s['name'] ? Colors.black : AppTheme.goldColor),
                        const SizedBox(height: 4),
                        Text(s['name'], style: TextStyle(fontSize: 12, color: _selectedService == s['name'] ? Colors.black : null)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (_selectedService != null) ...[
              CustomTextField(
                controller: _billNumberController,
                label: 'رقم الاشتراك',
                prefixIcon: Icons.confirmation_number,
                keyboardType: TextInputType.number,
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
                onPressed: (_billNumberController.text.isEmpty || _amountController.text.isEmpty)
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم دفع الفاتورة بنجاح')),
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
