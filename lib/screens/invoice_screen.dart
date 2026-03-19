import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import 'main_navigation.dart';

class InvoiceData {
  final String orderId;
  final DateTime date;
  final List items;
  final double subtotal;
  final double shipping;
  final double total;
  final String paymentMethod;
  final String address;

  InvoiceData({
    required this.orderId,
    required this.date,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.paymentMethod,
    required this.address,
  });
}

class InvoiceScreen extends StatelessWidget {
  final InvoiceData invoice;
  const InvoiceScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'تم الدفع بنجاح'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // أيقونة النجاح
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: Colors.green, size: 60),
            ),
            const SizedBox(height: 16),
            const Text(
              'تم تأكيد طلبك بنجاح!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'رقم الطلب: ${invoice.orderId}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            
            // بطاقة الفاتورة
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('تفاصيل الفاتورة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(height: 24),
                    
                    // التاريخ
                    _buildInfoRow('التاريخ', '${invoice.date.year}-${invoice.date.month}-${invoice.date.day}'),
                    const SizedBox(height: 8),
                    
                    // طريقة الدفع
                    _buildInfoRow('طريقة الدفع', invoice.paymentMethod),
                    const SizedBox(height: 8),
                    
                    // عنوان التوصيل
                    _buildInfoRow('عنوان التوصيل', invoice.address),
                    
                    const Divider(height: 24),
                    
                    // المنتجات
                    const Text('المنتجات', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...invoice.items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${item.product.title} x${item.quantity}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Text('${item.totalPrice.toStringAsFixed(0)} ر.ي'),
                        ],
                      ),
                    )),
                    
                    const Divider(height: 24),
                    
                    // المجاميع
                    _buildPriceRow('المجموع', invoice.subtotal),
                    _buildPriceRow('الشحن', invoice.shipping),
                    const Divider(height: 16),
                    _buildPriceRow('الإجمالي', invoice.total, isTotal: true),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // أزرار
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'متابعة التسوق',
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const MainNavigation()),
                        (route) => false,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'عرض الطلب',
                    onPressed: () {
                      // الانتقال إلى صفحة تفاصيل الطلب
                    },
                    isOutlined: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text('$label:', style: const TextStyle(color: Colors.grey)),
        ),
        Expanded(child: Text(value)),
      ],
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
}
