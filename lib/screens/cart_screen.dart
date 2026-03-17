import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {'id': 1, 'name': 'آيفون 15 برو ماكس', 'price': 450000, 'quantity': 1, 'image': 'https://via.placeholder.com/60'},
    {'id': 2, 'name': 'سماعات ايربودز برو', 'price': 45000, 'quantity': 2, 'image': 'https://via.placeholder.com/60'},
    {'id': 3, 'name': 'جراب حماية', 'price': 5000, 'quantity': 1, 'image': 'https://via.placeholder.com/60'},
  ];

  int get _totalPrice => _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

  void _updateQuantity(int id, bool increase) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item['id'] == id);
      if (increase) {
        _cartItems[index]['quantity']++;
      } else {
        if (_cartItems[index]['quantity'] > 1) {
          _cartItems[index]['quantity']--;
        } else {
          _cartItems.removeAt(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'السلة'),
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: isDark ? Colors.grey[700] : Colors.grey[300]),
                  const SizedBox(height: 20),
                  const Text('سلتك فارغة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  const SizedBox(height: 10),
                  const Text('أضف منتجات إلى السلة للمتابعة', style: TextStyle(color: Colors.grey, fontFamily: 'Changa')),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'تسوق الآن',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                                  const SizedBox(height: 4),
                                  Text('${item['price']} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontFamily: 'Changa')),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => _updateQuantity(item['id'], false),
                                ),
                                Text('${item['quantity']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => _updateQuantity(item['id'], true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('الإجمالي', style: TextStyle(fontSize: 16, fontFamily: 'Changa')),
                          Text('$_totalPrice ر.ي', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldColor, fontFamily: 'Changa')),
                        ],
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        text: 'إتمام الشراء',
                        onPressed: () {
                          Navigator.of(context).pushNamed('/checkout');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
