import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../services/supabase_service.dart';
import 'order_detail_screen.dart';
import 'login_screen.dart';

class CheckoutItem {
  final Map<String, dynamic> product;
  final int quantity;
  CheckoutItem({required this.product, required this.quantity});
  
  double get totalPrice => (product['price'] as num).toDouble() * quantity;
}

class CheckoutScreen extends StatefulWidget {
  final List<CheckoutItem> items;
  const CheckoutScreen({super.key, required this.items});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  String? _selectedAddress;
  String? _selectedPaymentMethod;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _addresses = const [
    {'name': 'محمد أحمد', 'address': 'صنعاء - شارع حدة', 'phone': '777123456', 'default': true},
    {'name': 'محمد أحمد', 'address': 'عدن - خور مكسر', 'phone': '777123456', 'default': false},
  ];

  double get _subtotal {
    return widget.items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get _shipping => 2000;
  double get _total => _subtotal + _shipping;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'إتمام الشراء'),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _currentStep < 2
            ? () {
                if (_currentStep == 0 && _selectedAddress == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('الرجاء اختيار عنوان التوصيل')),
                  );
                  return;
                }
                if (_currentStep == 1 && _selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('الرجاء اختيار طريقة الدفع')),
                  );
                  return;
                }
                setState(() => _currentStep++);
              }
            : null,
        onStepCancel: _currentStep > 0
            ? () => setState(() => _currentStep--)
            : null,
        steps: [
          Step(
            title: const Text('العنوان'),
            content: Column(
              children: _addresses.map((addr) {
                final isSelected = _selectedAddress == addr['address'];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : null,
                  child: ListTile(
                    title: Text(addr['name']),
                    subtitle: Text('${addr['address']} - ${addr['phone']}'),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: AppTheme.goldColor)
                        : Radio<String>(
                            value: addr['address'],
                            groupValue: _selectedAddress,
                            onChanged: (v) => setState(() => _selectedAddress = v),
                          ),
                    onTap: () => setState(() => _selectedAddress = addr['address']),
                  ),
                );
              }).toList(),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('الدفع'),
            content: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.account_balance_wallet, color: AppTheme.goldColor),
                  title: const Text('المحفظة'),
                  subtitle: const Text('الرصيد: 125,000 ر.ي'),
                  trailing: Radio<String>(
                    value: 'wallet',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (v) => setState(() => _selectedPaymentMethod = v),
                  ),
                  onTap: () => setState(() => _selectedPaymentMethod = 'wallet'),
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card, color: AppTheme.goldColor),
                  title: const Text('بطاقة ائتمان'),
                  subtitle: const Text('•••• 4242'),
                  trailing: Radio<String>(
                    value: 'card',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (v) => setState(() => _selectedPaymentMethod = v),
                  ),
                  onTap: () => setState(() => _selectedPaymentMethod = 'card'),
                ),
                ListTile(
                  leading: const Icon(Icons.account_balance, color: AppTheme.goldColor),
                  title: const Text('تحويل بنكي'),
                  subtitle: const Text('YE12 3456 7890'),
                  trailing: Radio<String>(
                    value: 'bank',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (v) => setState(() => _selectedPaymentMethod = v),
                  ),
                  onTap: () => setState(() => _selectedPaymentMethod = 'bank'),
                ),
              ],
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('مراجعة'),
            content: Column(
              children: [
                ...widget.items.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.product['title'] ?? 'منتج'),
                            Text('الكمية: ${item.quantity}', style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Text('${item.totalPrice.toStringAsFixed(0)} ر.ي'),
                    ],
                  ),
                )),
                const Divider(height: 32),
                _buildPriceRow('المجموع', _subtotal),
                _buildPriceRow('الشحن', _shipping),
                const Divider(height: 16),
                _buildPriceRow('الإجمالي', _total, isTotal: true),
              ],
            ),
            isActive: _currentStep >= 2,
            state: _currentStep == 2 ? StepState.editing : StepState.indexed,
          ),
        ],
      ),
      bottomNavigationBar: _currentStep == 2
          ? Container(
              padding: const EdgeInsets.all(16),
              child: CustomButton(
                text: 'تأكيد الدفع',
                onPressed: _processPayment,
                isLoading: _isProcessing,
              ),
            )
          : null,
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isTotal ? const TextStyle(fontWeight: FontWeight.bold) : null),
          Text(
            '${amount.toStringAsFixed(0)} ر.ي',
            style: isTotal ? const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold) : null,
          ),
        ],
      ),
    );
  }

  Future<void> _processPayment() async {
    if (!SupabaseService.isAuthenticated) {
      _showLoginDialog();
      return;
    }

    setState(() => _isProcessing = true);
    
    // محاكاة عملية الدفع
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    
    setState(() => _isProcessing = false);
    
    // إنشاء الطلب في قاعدة البيانات
    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
    
    // الانتقال إلى صفحة تفاصيل الطلب
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderDetailScreen(orderId: orderId),
      ),
    );
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الدخول مطلوب'),
        content: const Text('يرجى تسجيل الدخول لإتمام عملية الشراء'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text('تسجيل الدخول'),
          ),
        ],
      ),
    );
  }
}
