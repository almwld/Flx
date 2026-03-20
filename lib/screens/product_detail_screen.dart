import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import '../models/rating_model.dart';
import '../services/supabase_service.dart';
import 'checkout_screen.dart';
import 'login_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});
  @override State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1; int _currentImageIndex = 0; bool _isFavorite = false; bool _isLoading = false;
  List<ProductModel> _related = []; List<RatingModel> _ratings = []; double _avgRating = 0.0;

  @override void initState() { super.initState(); _checkFavorite(); _loadRelated(); _loadRatings(); }
  Future<void> _checkFavorite() async { if (SupabaseService.isAuthenticated) setState(() => _isFavorite = SupabaseService.isFavorite(widget.product.id) as bool); }
  Future<void> _toggleFavorite() async { if (!SupabaseService.isAuthenticated) { _showLoginDialog(); return; }
    setState(() => _isLoading = true);
    try { if (_isFavorite) await SupabaseService.removeFromFavorites(widget.product.id); else await SupabaseService.addToFavorites(widget.product.id);
      setState(() => _isFavorite = !_isFavorite); } catch (e) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e'))); }
    finally { setState(() => _isLoading = false); }
  }
  Future<void> _loadRelated() async { _related = await SupabaseService.getProducts(category: widget.product.category); _related.removeWhere((p) => p.id == widget.product.id); setState(() {}); }
  Future<void> _loadRatings() async { _ratings = await SupabaseService.getProductRatings(widget.product.id); _avgRating = await SupabaseService.getProductAverageRating(widget.product.id); setState(() {}); }
  void _showLoginDialog() { showDialog(context: context, builder: (_) => AlertDialog(title: const Text('تسجيل الدخول مطلوب'), content: const Text('يرجى تسجيل الدخول للإضافة للمفضلة'),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')), ElevatedButton(onPressed: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())); }, child: const Text('تسجيل الدخول'))])); }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark; final p = widget.product;
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(expandedHeight: 300, pinned: true, flexibleSpace: FlexibleSpaceBar(
          background: Stack(children: [
            if (p.images.isNotEmpty) CarouselSlider.builder(itemCount: p.images.length,
              options: CarouselOptions(height: 300, viewportFraction: 1.0, enableInfiniteScroll: p.images.length > 1, onPageChanged: (i, _) => setState(() => _currentImageIndex = i)),
              itemBuilder: (_, i, __) => CachedNetworkImage(imageUrl: p.images[i], fit: BoxFit.cover)),
            if (p.images.length > 1) Positioned(bottom: 16, left: 0, right: 0,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(p.images.length, (i) => Container(width: 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(shape: BoxShape.circle, color: _currentImageIndex == i ? AppTheme.goldColor : Colors.white.withOpacity(0.5)))))),
            Positioned(top: 40, right: 16, child: Row(children: [
              IconButton(icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white), onPressed: _toggleFavorite),
              const SizedBox(width: 8), IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: () {}) ])),
          ]),
        )),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Text(p.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              if (p.oldPrice != null) Text('${p.oldPrice!.toStringAsFixed(0)} ر.ي', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
              Text('${p.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.goldColor)) ]) ]),
          const SizedBox(height: 8),
          Row(children: [const Icon(Icons.star, color: Colors.amber, size: 16), const SizedBox(width: 4),
            Text('${p.rating.toStringAsFixed(1)} (${p.reviewCount} تقييم)', style: TextStyle(color: Colors.grey[600])) ]),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              CircleAvatar(backgroundColor: AppTheme.goldColor.withOpacity(0.2), child: const Icon(Icons.store, color: AppTheme.goldColor)),
              const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.sellerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(children: [const Icon(Icons.star, size: 12, color: Colors.amber), const SizedBox(width: 2), Text('${p.sellerRating}'), const SizedBox(width: 8),
                  const Icon(Icons.verified, size: 12, color: Colors.blue), const Text(' بائع موثوق') ]) ])),
              TextButton(onPressed: () {}, child: const Text('مشاهدة المتجر')) ])),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Icon(p.inStock ? Icons.check_circle : Icons.cancel, color: p.inStock ? Colors.green : Colors.red),
              const SizedBox(width: 12),
              Text(p.inStock ? 'متوفر في المخزون' : 'غير متوفر حالياً', style: TextStyle(color: p.inStock ? Colors.green : Colors.red, fontWeight: FontWeight.bold)) ])),
          const SizedBox(height: 16),
          const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8),
          Text(p.description, style: const TextStyle(height: 1.5)),
          const SizedBox(height: 16),
          if (p.inStock) Row(children: [const Text('الكمية:', style: TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 16),
            Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                IconButton(icon: const Icon(Icons.remove, size: 16), onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null),
                Container(width: 40, alignment: Alignment.center, child: Text('$_quantity')),
                IconButton(icon: const Icon(Icons.add, size: 16), onPressed: () => setState(() => _quantity++)) ])) ]),
          const SizedBox(height: 24),
          const Text('التقييمات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12),
          _ratings.isEmpty ? const Text('لا توجد تقييمات بعد') : Column(children: _ratings.take(3).map((r) => ListTile(
            leading: CircleAvatar(child: Text(r.userName[0])),
            title: Text(r.userName), subtitle: Row(children: List.generate(5, (i) => Icon(Icons.star, size: 14, color: i < r.rating ? Colors.amber : Colors.grey))),
            trailing: Text(r.formattedDate) )).toList()),
          const SizedBox(height: 24),
          if (_related.isNotEmpty) ...[ const Text('منتجات مشابهة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12),
            SizedBox(height: 150, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _related.length,
              itemBuilder: (_, i) => GestureDetector(onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: _related[i]))),
                child: Container(width: 100, margin: const EdgeInsets.only(right: 12), decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
                  child: Column(children: [
                    Expanded(child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: CachedNetworkImage(imageUrl: _related[i].images.isNotEmpty ? _related[i].images.first : '', fit: BoxFit.cover, width: double.infinity))),
                    Padding(padding: const EdgeInsets.all(4), child: Text(_related[i].title, style: const TextStyle(fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)) ])))) ],
        ]))),
      ]),
      bottomNavigationBar: p.inStock ? Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface),
        child: SafeArea(child: Row(children: [
          Expanded(child: CustomButton(text: 'اشتر الآن', onPressed: () {
            if (!SupabaseService.isAuthenticated) { _showLoginDialog(); return; }
            Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(items: [CheckoutItem(product: p.toJson(), quantity: _quantity)]))); })),
          const SizedBox(width: 12),
          Container(width: 50, height: 50, decoration: BoxDecoration(border: Border.all(color: AppTheme.goldColor), borderRadius: BorderRadius.circular(12)),
            child: IconButton(icon: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: _toggleFavorite, color: AppTheme.goldColor)) ]))) : null,
    );
  }
}
