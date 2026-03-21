import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';
import 'order_detail_screen.dart';
import 'login_screen.dart';

class CheckoutItem {
  final ProductModel product;
  final int quantity;
  CheckoutItem({required this.product, required this.quantity});
  double get totalPrice => product.price * quantity;
}

class CheckoutScreen extends StatefulWidget {
  final List<CheckoutItem> items;
  const CheckoutScreen({super.key, required this.items});
  @override State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  String? _selectedAddress;
  String? _selectedPaymentMethod;
  bool _isProcessing = false;

  double get _subtotal => widget.items.fold(0, (sum, i) => sum + i.totalPrice);
  double get _shipping => 2000;
  double get _total => _subtotal + _shipping;

  Future<void> _processPayment() async {
    if (!SupabaseService.isAuthenticated) {
      _showLoginDialog();
      return;
    }
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isProcessing = false);
    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
    await SupabaseService.createOrder({
      'total_amount': _total,
      'shipping_address': _selectedAddress,
      'payment_method': _selectedPaymentMethod,
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إتمام الطلب بنجاح'), backgroundColor: AppTheme.success));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: orderId)));
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الدخول مطلوب'),
        content: const Text('يرجى تسجيل الدخول لإتمام عملية الشراء'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(onPressed: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())); }, child: const Text('تسجيل الدخول')),
        ],
      ),
    );
  }

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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اختر عنوان التوصيل')));
                  return;
                }
                if (_currentStep == 1 && _selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اختر طريقة الدفع')));
                  return;
                }
                setState(() => _currentStep++);
              }
            : null,
        onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep--) : null,
        steps: [
          Step(
            title: const Text('العنوان'),
            content: Column(
              children: [
                ListTile(
                  title: const Text('صنعاء - شارع حدة'),
                  subtitle: const Text('محمد أحمد - 777123456'),
                  trailing: Radio<String>(
                    value: 'صنعاء - شارع حدة',
                    groupValue: _selectedAddress,
                    onChanged: (v) => setState(() => _selectedAddress = v),
                  ),
                  onTap: () => setState(() => _selectedAddress = 'صنعاء - شارع حدة'),
                ),
                ListTile(
                  title: const Text('عدن - خور مكسر'),
                  subtitle: const Text('محمد أحمد - 777123456'),
                  trailing: Radio<String>(
                    value: 'عدن - خور مكسر',
                    groupValue: _selectedAddress,
                    onChanged: (v) => setState(() => _selectedAddress = v),
                  ),
                  onTap: () => setState(() => _selectedAddress = 'عدن - خور مكسر'),
                ),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('الدفع'),
            content: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.account_balance_wallet, color: AppTheme.goldColor),
                  title: const Text('المحفظة'),
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
                  trailing: Radio<String>(
                    value: 'card',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (v) => setState(() => _selectedPaymentMethod = v),
                  ),
                  onTap: () => setState(() => _selectedPaymentMethod = 'card'),
                ),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('مراجعة'),
            content: Column(
              children: [
                ...widget.items.map((i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(width: 50, height: 50, color: Colors.grey[300], child: const Icon(Icons.image)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(i.product.title)),
                      Text('${i.totalPrice.toStringAsFixed(0)} ر.ي'),
                    ],
                  ),
                )),
                const Divider(),
                _buildPriceRow('المجموع', _subtotal),
                _buildPriceRow('الشحن', _shipping),
                const Divider(),
                _buildPriceRow('الإجمالي', _total, isTotal: true),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
      bottomNavigationBar: _currentStep == 2
          ? Container(
              padding: const EdgeInsets.all(16),
              child: CustomButton(text: 'تأكيد الدفع', onPressed: _processPayment, isLoading: _isProcessing),
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
          Text('${amount.toStringAsFixed(0)} ر.ي', style: isTotal ? const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }
}
