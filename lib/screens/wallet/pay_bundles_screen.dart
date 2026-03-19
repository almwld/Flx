import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class PayBundlesScreen extends StatefulWidget {
  const PayBundlesScreen({super.key});

  @override
  State<PayBundlesScreen> createState() => _PayBundlesScreenState();
}

class _PayBundlesScreenState extends State<PayBundlesScreen> {
  final _numberController = TextEditingController();
  String? _selectedProvider;
  String? _selectedBundle;
  bool _isLoading = false;

  final List<String> _providers = ['سبأفون', 'يمن موبايل', 'إم تي إن'];

  final Map<String, List<Map<String, dynamic>>> _bundles = {
    'سبأفون': [
      {'name': 'باقة 5 جيجا', 'price': '5,000', 'data': '5 GB', 'validity': '30 يوم'},
      {'name': 'باقة 10 جيجا', 'price': '8,000', 'data': '10 GB', 'validity': '30 يوم'},
      {'name': 'باقة 20 جيجا', 'price': '12,000', 'data': '20 GB', 'validity': '30 يوم'},
    ],
    'يمن موبايل': [
      {'name': 'باقة 3 جيجا', 'price': '3,500', 'data': '3 GB', 'validity': '30 يوم'},
      {'name': 'باقة 8 جيجا', 'price': '6,500', 'data': '8 GB', 'validity': '30 يوم'},
      {'name': 'باقة 15 جيجا', 'price': '10,000', 'data': '15 GB', 'validity': '30 يوم'},
    ],
    'إم تي إن': [
      {'name': 'باقة 4 جيجا', 'price': '4,500', 'data': '4 GB', 'validity': '30 يوم'},
      {'name': 'باقة 12 جيجا', 'price': '9,000', 'data': '12 GB', 'validity': '30 يوم'},
      {'name': 'باقة 25 جيجا', 'price': '15,000', 'data': '25 GB', 'validity': '30 يوم'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'سداد باقات'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedProvider,
              hint: const Text('اختر مزود الخدمة'),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: _providers.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) {
                setState(() {
                  _selectedProvider = v;
                  _selectedBundle = null;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_selectedProvider != null) ...[
              DropdownButtonFormField<String>(
                value: _selectedBundle,
                hint: const Text('اختر الباقة'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: _bundles[_selectedProvider]!.map((b) => DropdownMenuItem(
                  value: b['name'],
                  child: Text('${b['name']} - ${b['price']} ر.ي'),
                )).toList(),
                onChanged: (v) => setState(() => _selectedBundle = v),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _numberController,
                label: 'رقم الهاتف',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              if (_selectedBundle != null) ...[
                Card(
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('الباقة:'),
                            Text(_selectedBundle!),
                          ],
                        ),
                        const Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('البيانات:'),
                            Text(_bundles[_selectedProvider]!.firstWhere((b) => b['name'] == _selectedBundle)['data']),
                          ],
                        ),
                        const Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('المدة:'),
                            Text(_bundles[_selectedProvider]!.firstWhere((b) => b['name'] == _selectedBundle)['validity']),
                          ],
                        ),
                        const Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('السعر:'),
                            Text(_bundles[_selectedProvider]!.firstWhere((b) => b['name'] == _selectedBundle)['price']),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'شراء الباقة',
                  onPressed: _numberController.text.isEmpty
                      ? null
                      : () {
                          setState(() => _isLoading = true);
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() => _isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تم شراء الباقة بنجاح للرقم ${_numberController.text}')),
                            );
                            Navigator.pop(context);
                          });
                        },
                  isLoading: _isLoading,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
