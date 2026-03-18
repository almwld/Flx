import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ReceiveTransferRequestScreen extends StatefulWidget {
  const ReceiveTransferRequestScreen({super.key});

  @override
  State<ReceiveTransferRequestScreen> createState() => _ReceiveTransferRequestScreenState();
}

class _ReceiveTransferRequestScreenState extends State<ReceiveTransferRequestScreen> {
  final _codeController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  final List<Map<String, dynamic>> _requests = const [
    {'from': 'أحمد محمد', 'amount': '50,000', 'code': 'ABC123', 'status': 'قيد الانتظار'},
    {'from': 'فاطمة علي', 'amount': '25,000', 'code': 'XYZ789', 'status': 'متاحة'},
    {'from': 'خالد سالم', 'amount': '100,000', 'code': 'DEF456', 'status': 'متاحة'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'استلام حوالة'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('أدخل رمز الحوالة', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: _codeController,
                      label: 'رمز الحوالة',
                      prefixIcon: Icons.qr_code,
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'البحث',
                      onPressed: _codeController.text.isEmpty ? null : () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('الحوالات الواردة', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ..._requests.map((r) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                  child: Text(r['from'][0], style: const TextStyle(color: AppTheme.goldColor)),
                ),
                title: Text(r['from']),
                subtitle: Text('المبلغ: ${r['amount']} ر.ي'),
                trailing: r['status'] == 'متاحة'
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() => _isLoading = true);
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() => _isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تم استلام حوالة بقيمة ${r['amount']} ريال')),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.goldColor,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('استلام'),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('قيد الانتظار', style: TextStyle(color: Colors.orange)),
                      ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
