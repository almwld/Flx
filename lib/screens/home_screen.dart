import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
  int _currentSlide = 0;
  List<ProductModel> _featuredProducts = [];
  List<ProductModel> _latestProducts = [];
  bool _isLoading = true;

  // قائمة السلايدرات الـ 6
  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'عرض خاص ١',
      'subtitle': 'خصم يصل إلى ٥٠٪',
      'image': 'https://images.unsplash.com/photo-1607083206864-6c7e3f2c7b3f?w=400',
      'color': Color(0xFFD4AF37),
    },
    {
      'title': 'عرض خاص ٢',
      'subtitle': 'توصيل مجاني',
      'image': 'https://images.unsplash.com/photo-1607083206325-cafd7b5f9c9b?w=400',
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'عرض خاص ٣',
      'subtitle': 'اشتر ٢ واحصل ١ مجاناً',
      'image': 'https://images.unsplash.com/photo-1607083206864-6c7e3f2c7b3f?w=400',
      'color': Color(0xFF2196F3),
    },
    {
      'title': 'عرض خاص ٤',
      'subtitle': 'شحن سريع',
      'image': 'https://images.unsplash.com/photo-1607083206325-cafd7b5f9c9b?w=400',
      'color': Color(0xFFFF9800),
    },
    {
      'title': 'عرض خاص ٥',
      'subtitle': 'ضمان لمدة عام',
      'image': 'https://images.unsplash.com/photo-1607083206864-6c7e3f2c7b3f?w=400',
      'color': Color(0xFF9C27B0),
    },
    {
      'title': 'عرض خاص ٦',
      'subtitle': 'تخفيضات نهاية الموسم',
      'image': 'https://images.unsplash.com/photo-1607083206325-cafd7b5f9c9b?w=400',
      'color': Color(0xFFF44336),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    
    _featuredProducts = List.generate(5, (index) => ProductModel(
      id: 'featured_$index',
      title: 'منتج مميز ${index + 1}',
      description: 'وصف المنتج المميز',
      price: 1500.0 * (index + 1),
      currency: 'YER',
      images: ['https://picsum.photos/300/300?random=${index + 100}'],
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
      images: ['https://picsum.photos/300/300?random=$index'],
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
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('قريباً')))),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.goldColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.celebration, color: Colors.black),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // السلايدر المتحرك (6 سلايدرات)
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      CarouselSlider.builder(
                        itemCount: _slides.length,
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          viewportFraction: 0.9,
                          onPageChanged: (index, reason) {
                            setState(() => _currentSlide = index);
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final slide = _slides[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(slide['image']),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: slide['color'].withOpacity(0.5),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      slide['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      slide['subtitle'],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      AnimatedSmoothIndicator(
                        activeIndex: _currentSlide,
                        count: _slides.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppTheme.goldColor,
                          dotColor: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 3,
                          spacing: 8,
                        ),
                      ),
                    ],
                  ),
                ),

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
