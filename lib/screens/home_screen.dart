import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'products_screen.dart';
import 'product_detail_screen.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';
import '../utils/responsive.dart'; // إضافة الاستيراد

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0; List<ProductModel> _featured = []; List<ProductModel> _latest = []; bool _isLoading = true;
  final List<Map<String, dynamic>> _slides = List.generate(6, (i) => {
    'title': 'عرض خاص ${i+1}', 'subtitle': 'خصم يصل إلى ٥٠٪', 'image': 'https://picsum.photos/400/200?${i+1}'
  });

  @override void initState() { super.initState(); _loadProducts(); }
  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    _featured = await SupabaseService.getFeaturedProducts(limit: 5);
    _latest = await SupabaseService.getLatestProducts(limit: 10);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(slivers: [
              SliverToBoxAdapter(child: Column(children: [
                const SizedBox(height: 8),
                CarouselSlider.builder(itemCount: _slides.length,
                  options: CarouselOptions(height: 200, autoPlay: true, autoPlayInterval: const Duration(seconds: 5), enlargeCenterPage: true, viewportFraction: 0.9,
                    onPageChanged: (i, _) => setState(() => _currentSlide = i)),
                  itemBuilder: (_, i, __) {
                    final s = _slides[i];
                    return Container(margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: DecorationImage(image: NetworkImage(s['image']), fit: BoxFit.cover)),
                      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)])),
                        child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text(s['title'], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 4),
                            Text(s['subtitle'], style: const TextStyle(color: Colors.white70, fontSize: 16))])))); }),
                const SizedBox(height: 12),
                AnimatedSmoothIndicator(activeIndex: _currentSlide, count: _slides.length,
                  effect: ExpandingDotsEffect(activeDotColor: AppTheme.goldColor, dotColor: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    dotHeight: 8, dotWidth: 8, expansionFactor: 3, spacing: 8)),
              ])),
              // إصلاح: استخدام Responsive.sp
              SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(16), 
                child: Text('منتجات مميزة', style: TextStyle(fontSize: Responsive.sp(20), fontWeight: FontWeight.bold)))),
              // إصلاح: إغلاق قوس SliverToBoxAdapter بشكل صحيح
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 220, 
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, 
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _featured.length,
                    itemBuilder: (_, i) { 
                      final p = _featured[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
                        child: Container(
                          width: 150, 
                          margin: const EdgeInsets.only(right: 12), 
                          decoration: BoxDecoration(
                            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                            borderRadius: BorderRadius.circular(12), 
                            border: Border.all(color: AppTheme.goldColor.withOpacity(0.3))
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Expanded(
                              flex: 2, 
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                child: CachedNetworkImage(imageUrl: p.images.first, fit: BoxFit.cover, width: double.infinity)
                              )
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8), 
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(p.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  const Spacer(),
                                  Text('${p.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontSize: 11, color: AppTheme.goldColor, fontWeight: FontWeight.bold))
                                ])
                              )
                            ),
                          ])
                        )
                      );
                    }
                  )
                )
              ),
              SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(16), 
                child: Text('أحدث المنتجات', style: TextStyle(fontSize: Responsive.sp(20), fontWeight: FontWeight.bold)))),
              SliverPadding(
                padding: const EdgeInsets.all(16), 
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  delegate: SliverChildBuilderDelegate((_, i) { 
                    final p = _latest[i];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.darkCard : AppTheme.lightCard, 
                          borderRadius: BorderRadius.circular(12), 
                          border: Border.all(color: AppTheme.goldColor.withOpacity(0.3))
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Expanded(
                            flex: 3, 
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), 
                                child: CachedNetworkImage(imageUrl: p.images.first, fit: BoxFit.cover, width: double.infinity)
                              ),
                              if (!p.inStock) 
                                const Positioned(
                                  top: 8, left: 8, 
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(12))),
                                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
                                      child: Text('غير متوفر', style: TextStyle(color: Colors.white, fontSize: 10)))
                                  )
                                )
                            ])
                          ),
                          Expanded(
                            flex: 2, 
                            child: Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const Spacer(),
                              Row(children: [
                                if (p.oldPrice != null) 
                                  Text('${p.oldPrice!.toStringAsFixed(0)} ر.ي', 
                                    style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 9, color: Colors.grey)
                                  ),
                                const SizedBox(width: 4),
                                Expanded(child: Text('${p.price.toStringAsFixed(0)} ر.ي', 
                                  style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 11)
                                ))
                              ])
                            ]))
                          ),
                        ])
                      )
                    );
                  }, childCount: _latest.length)
                )
              )
            ]),
    );
  }
}
