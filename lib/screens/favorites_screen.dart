import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';
import 'product_detail_screen.dart';
import 'login_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<ProductModel> _favorites = [];
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() {
    setState(() {
      _isAuthenticated = SupabaseService.isAuthenticated;
    });
    if (_isAuthenticated) {
      _loadFavorites();
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);
    try {
      final favorites = await SupabaseService.getFavorites();
      setState(() {
        _favorites = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }

  Future<void> _removeFromFavorites(String productId) async {
    try {
      await SupabaseService.removeFromFavorites(productId);
      setState(() {
        _favorites.removeWhere((p) => p.id == productId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت الإزالة من المفضلة')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المفضلة'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_isAuthenticated
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: isDark ? Colors.grey[700] : Colors.grey[300]),
                      const SizedBox(height: 16),
                      const Text(
                        'سجل دخول لمشاهدة مفضلتك',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'تسجيل الدخول',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                )
              : _favorites.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border, size: 80, color: isDark ? Colors.grey[700] : Colors.grey[300]),
                          const SizedBox(height: 16),
                          const Text('لا توجد عناصر في المفضلة'),
                          const SizedBox(height: 8),
                          const Text('أضف منتجات إلى المفضلة للمتابعة'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _favorites.length,
                      itemBuilder: (context, index) {
                        final product = _favorites[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(product: product),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: product.images.isNotEmpty ? product.images.first : '',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) => Container(
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (_, __, ___) => Container(
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.broken_image, size: 30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${product.price.toStringAsFixed(0)} ${product.currencySymbol}',
                                          style: const TextStyle(color: AppTheme.goldColor),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, size: 12, color: Colors.amber),
                                            const SizedBox(width: 2),
                                            Text(product.rating.toStringAsFixed(1)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeFromFavorites(product.id),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
