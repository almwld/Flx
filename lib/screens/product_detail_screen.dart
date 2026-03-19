import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import 'checkout_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final p = widget.product;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // صور المنتج
                  CarouselSlider.builder(
                    itemCount: p.images.length,
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: p.images.length > 1,
                      onPageChanged: (i, _) => setState(() => _currentImageIndex = i),
                    ),
                    itemBuilder: (_, i, __) {
                      return CachedNetworkImage(
                        imageUrl: p.images[i],
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(color: Colors.grey[300]),
                        errorWidget: (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image),
                        ),
                      );
                    },
                  ),
                  // مؤشر الصفحات
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(p.images.length, (i) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == i
                              ? AppTheme.goldColor
                              : Colors.white.withOpacity(0.5),
                        ),
                      )),
                    ),
                  ),
                  // أزرار في الأعلى
                  Positioned(
                    top: 40,
                    right: 16,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () => setState(() => _isFavorite = !_isFavorite),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.share, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والسعر
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          p.title,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (p.oldPrice != null)
                            Text(
                              '${p.oldPrice!.toStringAsFixed(0)} ر.ي',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          Text(
                            '${p.price.toStringAsFixed(0)} ر.ي',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.goldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // التقييم
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${p.rating.toStringAsFixed(1)} (${p.reviewCount} تقييم)',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.shopping_bag, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${p.reviewCount} مبيعات', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // معلومات البائع
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: const Icon(Icons.store, color: AppTheme.goldColor),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.sellerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  const Icon(Icons.star, size: 12, color: Colors.amber),
                                  const SizedBox(width: 2),
                                  Text('${p.sellerRating}'),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.verified, size: 12, color: Colors.blue),
                                  const Text(' بائع موثوق'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('مشاهدة المتجر'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // المخزون
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          p.inStock ? Icons.check_circle : Icons.cancel,
                          color: p.inStock ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          p.inStock ? 'متوفر في المخزون' : 'غير متوفر حالياً',
                          style: TextStyle(
                            color: p.inStock ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // الوصف
                  const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(p.description, style: const TextStyle(height: 1.5)),
                  const SizedBox(height: 16),
                  // الكمية
                  Row(
                    children: [
                      const Text('الكمية:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: _quantity > 1
                                  ? () => setState(() => _quantity--)
                                  : null,
                            ),
                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: Text('$_quantity'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () => setState(() => _quantity++),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'اشتر الآن',
                  onPressed: p.inStock
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                items: [CheckoutItem(product: p, quantity: _quantity)],
                              ),
                            ),
                          );
                        }
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.goldColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () => setState(() => _isFavorite = !_isFavorite),
                  color: AppTheme.goldColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
