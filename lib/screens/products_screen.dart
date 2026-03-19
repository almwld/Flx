import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'product_detail_screen.dart';
import '../models/product_model.dart';

class ProductsScreen extends StatefulWidget {
  final String? category;
  const ProductsScreen({super.key, this.category});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String _selectedSort = 'الأحدث';
  final List<String> _sortOptions = ['الأحدث', 'السعر: الأقل', 'السعر: الأعلى', 'الأكثر مبيعاً'];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    // محاكاة تحميل البيانات من Supabase
    await Future.delayed(const Duration(seconds: 1));
    
    // بيانات تجريبية - سيتم استبدالها بـ Supabase لاحقاً
    _products = List.generate(10, (index) => ProductModel(
      id: 'prod_$index',
      title: 'منتج ${index + 1}',
      description: 'وصف المنتج ${index + 1} - هذا وصف تفصيلي للمنتج',
      price: 1000.0 * (index + 1),
      oldPrice: index % 2 == 0 ? 1200.0 * (index + 1) : null,
      currency: 'YER',
      images: [
        'https://source.unsplash.com/random/300x300?sig=$index&product',
      ],
      category: 'إلكترونيات',
      subCategory: 'هواتف',
      sellerId: 'seller_1',
      sellerName: 'متجر التقنية',
      sellerRating: 4.5,
      inStock: index % 3 != 0,
      rating: 4.0 + (index % 5) / 10,
      reviewCount: 10 + index * 5,
      createdAt: DateTime.now(),
    ));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.category ?? 'المنتجات',
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط الترتيب
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_products.length} منتج',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                DropdownButton<String>(
                  value: _selectedSort,
                  items: _sortOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedSort = value!);
                    _sortProducts(value!);
                  },
                  underline: Container(),
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
          
          // قائمة المنتجات
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _products.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inventory_2, size: 80, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text('لا توجد منتجات', style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _products.length,
                        itemBuilder: (ctx, i) {
                          final p = _products[i];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(product: p),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // صورة المنتج
                                  Expanded(
                                    flex: 3,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: p.images.first,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            placeholder: (_, __) => Container(
                                              color: Colors.grey[300],
                                              child: const Center(
                                                child: CircularProgressIndicator(strokeWidth: 2),
                                              ),
                                            ),
                                            errorWidget: (_, __, ___) => Container(
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.broken_image),
                                            ),
                                          ),
                                        ),
                                        if (!p.inStock)
                                          Positioned(
                                            top: 8,
                                            left: 8,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                'غير متوفر',
                                                style: TextStyle(color: Colors.white, fontSize: 10),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  // تفاصيل المنتج
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            p.title,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              if (p.oldPrice != null) ...[
                                                Text(
                                                  '${p.oldPrice!.toStringAsFixed(0)} ر.ي',
                                                  style: const TextStyle(
                                                    decoration: TextDecoration.lineThrough,
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                              ],
                                              Text(
                                                '${p.price.toStringAsFixed(0)} ر.ي',
                                                style: const TextStyle(
                                                  color: AppTheme.goldColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              const Icon(Icons.star, size: 12, color: Colors.amber),
                                              const SizedBox(width: 2),
                                              Text(
                                                p.rating.toStringAsFixed(1),
                                                style: const TextStyle(fontSize: 10),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '(${p.reviewCount})',
                                                style: const TextStyle(fontSize: 9, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('تصفية المنتجات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // أضف خيارات التصفية هنا
            ListTile(
              title: const Text('إعادة تعيين'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _sortProducts(String option) {
    setState(() {
      switch (option) {
        case 'السعر: الأقل':
          _products.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'السعر: الأعلى':
          _products.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'الأكثر مبيعاً':
          // ترتيب حسب المبيعات (تجريبي)
          break;
        default:
          _products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    });
  }
}
