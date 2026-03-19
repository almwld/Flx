import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'products_screen.dart';
import 'product_detail_screen.dart';
import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> _featuredProducts = [];
  List<ProductModel> _latestProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    // محاكاة تحميل البيانات
    await Future.delayed(const Duration(seconds: 1));
    
    // بيانات تجريبية
    _featuredProducts = List.generate(5, (index) => ProductModel(
      id: 'featured_$index',
      title: 'منتج مميز ${index + 1}',
      description: 'وصف المنتج المميز',
      price: 1500.0 * (index + 1),
      currency: 'YER',
      images: ['https://picsum.photos/300/300?random=
      category: 'إلكترونيات',
      subCategory: 'هواتف',
      sellerId: 'seller_1',
      sellerName: 'متجر مميز',
      sellerRating: 4.8,
      inStock: true,
      rating: 4.5,
      reviewCount: 100 + index * 10,
      createdAt: DateTime.now(),
    ));
    
    _latestProducts = List.generate(10, (index) => ProductModel(
      id: 'latest_$index',
      title: 'منتج جديد ${index + 1}',
      description: 'وصف المنتج الجديد',
      price: 800.0 * (index + 1),
      oldPrice: index % 2 == 0 ? 1000.0 * (index + 1) : null,
      currency: 'YER',
      images: ['https://picsum.photos/300/300?random=
      category: 'إلكترونيات',
      subCategory: 'هواتف',
      sellerId: 'seller_2',
      sellerName: 'متجر جديد',
      sellerRating: 4.2,
      inStock: index % 3 != 0,
      rating: 4.0,
      reviewCount: 50 + index * 5,
      createdAt: DateTime.now(),
    ));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // شريط الأقسام السريعة
                SliverToBoxAdapter(
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 8,
                      itemBuilder: (_, i) {
                        final categories = ['إلكترونيات', 'ملابس', 'أثاث', 'سيارات', 'عقارات', 'خدمات', 'مطاعم', 'ألعاب'];
                        final icons = [
                          Icons.phone_android,
                          Icons.checkroom,
                          Icons.chair,
                          Icons.directions_car,
                          Icons.home,
                          Icons.build,
                          Icons.restaurant,
                          Icons.sports_esports,
                        ];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductsScreen(category: categories[i]),
                              ),
                            );
                          },
                          child: Container(
                            width: 70,
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppTheme.goldColor.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(icons[i], color: AppTheme.goldColor),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  categories[i],
                                  style: const TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // عنوان المنتجات المميزة
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'منتجات مميزة',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                
                // قائمة المنتجات المميزة (أفقية)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _featuredProducts.length,
                      itemBuilder: (_, i) {
                        final p = _featuredProducts[i];
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
                            width: 150,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: CachedNetworkImage(
                                      imageUrl: p.images.first,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder: (_, __) => Container(color: Colors.grey[300]),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          p.title,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${p.price.toStringAsFixed(0)} ر.ي',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppTheme.goldColor,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                ),
                
                // عنوان أحدث المنتجات
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'أحدث المنتجات',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                
                // قائمة أحدث المنتجات (شبكة)
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (_, i) {
                        final p = _latestProducts[i];
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
                                Expanded(
                                  flex: 3,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                        child: CachedNetworkImage(
                                          imageUrl: p.images.first,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          placeholder: (_, __) => Container(color: Colors.grey[300]),
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
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          p.title,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            if (p.oldPrice != null) ...[
                                              Text(
                                                '${p.oldPrice!.toStringAsFixed(0)} ر.ي',
                                                style: const TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  fontSize: 9,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                            ],
                                            Expanded(
                                              child: Text(
                                                '${p.price.toStringAsFixed(0)} ر.ي',
                                                style: const TextStyle(
                                                  color: AppTheme.goldColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
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
                      childCount: _latestProducts.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
