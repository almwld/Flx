import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';
import 'checkout_screen.dart';
import 'login_screen.dart';

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
  bool _isLoading = false;
  List<ProductModel> _relatedProducts = [];

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
    _loadRelatedProducts();
  }

  Future<void> _checkIfFavorite() async {
    if (SupabaseService.isAuthenticated) {
      final isFav = await SupabaseService.isFavorite(widget.product.id);
      setState(() => _isFavorite = isFav);
    }
  }

  Future<void> _toggleFavorite() async {
    if (!SupabaseService.isAuthenticated) {
      _showLoginDialog();
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      if (_isFavorite) {
        await SupabaseService.removeFromFavorites(widget.product.id);
      } else {
        await SupabaseService.addToFavorites(widget.product.id);
      }
      setState(() => _isFavorite = !_isFavorite);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadRelatedProducts() async {
    final products = await SupabaseService.getProducts(
      category: widget.product.category,
    );
    setState(() {
      _relatedProducts = products
          .where((p) => p.id != widget.product.id)
          .take(5)
          .toList();
    });
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الدخول مطلوب'),
        content: const Text('يرجى تسجيل الدخول لإضافة المنتج إلى المفضلة'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text('تسجيل الدخول'),
          ),
        ],
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    ... // (المحتوى الحالي)
  }

  Widget _buildRatingPreview(RatingModel rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.goldColor.withOpacity(0.2),
            child: Text(rating.userName[0], style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rating.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < rating.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 10,
                    );
                  }),
                ),
              ],
            ),
          ),
          Text(rating.formattedDate, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}
