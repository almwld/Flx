import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';
import '../models/product_model.dart';
import 'product_detail_screen.dart';
import 'login_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<ProductModel> _favorites = []; bool _isLoading = true; bool _isAuth = false;

  @override void initState() { super.initState(); _isAuth = SupabaseService.isAuthenticated; if (_isAuth) _loadFavorites(); else setState(() => _isLoading = false); }
  Future<void> _loadFavorites() async { _favorites = await SupabaseService.getFavorites(); setState(() => _isLoading = false); }
  Future<void> _remove(String id) async { await SupabaseService.removeFromFavorites(id); _loadFavorites(); }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'المفضلة'),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : !_isAuth ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.favorite_border, size: 80, color: isDark ? Colors.grey[700] : Colors.grey[300]), const SizedBox(height: 16),
        const Text('سجل دخول لمشاهدة مفضلتك', style: TextStyle(fontSize: 18)), const SizedBox(height: 16),
        ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())), child: const Text('تسجيل الدخول')) ])) :
        _favorites.isEmpty ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.favorite_border, size: 80, color: isDark ? Colors.grey[700] : Colors.grey[300]), const SizedBox(height: 16), const Text('لا توجد عناصر في المفضلة') ])) :
        ListView.builder(padding: const EdgeInsets.all(16), itemCount: _favorites.length,
          itemBuilder: (_, i) { final p = _favorites[i];
            return Card(margin: const EdgeInsets.only(bottom: 12), child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
              child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
                ClipRRect(borderRadius: BorderRadius.circular(8), child: CachedNetworkImage(imageUrl: p.images.isNotEmpty ? p.images.first : '', width: 70, height: 70, fit: BoxFit.cover)),
                const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4), Text('${p.price.toStringAsFixed(0)} ${p.currencySymbol}', style: const TextStyle(color: AppTheme.goldColor)),
                  const SizedBox(height: 4), Row(children: [const Icon(Icons.star, size: 12, color: Colors.amber), const SizedBox(width: 2), Text(p.rating.toStringAsFixed(1)) ]),
                ])), IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _remove(p.id)) ])))); }),
    );
  }
}
