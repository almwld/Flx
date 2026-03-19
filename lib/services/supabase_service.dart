import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';
import '../models/product_model.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  // ==================== المصادقة ====================
  static User? get currentUser => client.auth.currentUser;
  static bool get isAuthenticated => currentUser != null;

  static Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  // ==================== المنتجات ====================
  static Future<List<ProductModel>> getProducts({
    String? category,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    String? sortBy = 'created_at',
    bool ascending = false,
  }) async {
    try {
      // بناء الاستعلام الأساسي
      var query = client
          .from('products')
          .select('*, profiles!products_seller_id_fkey(*)')
          .order(sortBy!, ascending: ascending);

      // تطبيق الفلاتر
      if (category != null && category.isNotEmpty && category != 'الكل') {
        query = query.eq('category', category);
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.ilike('title', '%$searchQuery%');
      }

      if (minPrice != null) {
        query = query.gte('price', minPrice);
      }

      if (maxPrice != null) {
        query = query.lte('price', maxPrice);
      }

      final response = await query;

      // تحويل النتائج
      final List<ProductModel> products = [];
      for (var item in response) {
        final sellerData = item['profiles'] ?? {};
        products.add(ProductModel.fromJson({
          ...item,
          'seller_name': sellerData['full_name'],
          'seller_rating': sellerData['rating'],
          'seller_avatar': sellerData['avatar_url'],
        }));
      }
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<ProductModel?> getProduct(String id) async {
    try {
      final response = await client
          .from('products')
          .select('*, profiles!products_seller_id_fkey(*)')
          .eq('id', id)
          .single();

      final sellerData = response['profiles'] ?? {};
      return ProductModel.fromJson({
        ...response,
        'seller_name': sellerData['full_name'],
        'seller_rating': sellerData['rating'],
        'seller_avatar': sellerData['avatar_url'],
      });
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }

  static Future<List<ProductModel>> getFeaturedProducts({int limit = 5}) async {
    try {
      final response = await client
          .from('products')
          .select('*, profiles!products_seller_id_fkey(*)')
          .eq('is_featured', true)
          .order('created_at', ascending: false)
          .limit(limit);

      final List<ProductModel> products = [];
      for (var item in response) {
        final sellerData = item['profiles'] ?? {};
        products.add(ProductModel.fromJson({
          ...item,
          'seller_name': sellerData['full_name'],
          'seller_rating': sellerData['rating'],
        }));
      }
      return products;
    } catch (e) {
      print('Error fetching featured products: $e');
      return [];
    }
  }

  static Future<List<ProductModel>> getLatestProducts({int limit = 10}) async {
    try {
      final response = await client
          .from('products')
          .select('*, profiles!products_seller_id_fkey(*)')
          .order('created_at', ascending: false)
          .limit(limit);

      final List<ProductModel> products = [];
      for (var item in response) {
        final sellerData = item['profiles'] ?? {};
        products.add(ProductModel.fromJson({
          ...item,
          'seller_name': sellerData['full_name'],
          'seller_rating': sellerData['rating'],
        }));
      }
      return products;
    } catch (e) {
      print('Error fetching latest products: $e');
      return [];
    }
  }

  // ==================== المفضلة ====================
  static Future<void> addToFavorites(String productId) async {
    try {
      await client.from('favorites').insert({
        'user_id': currentUser!.id,
        'product_id': productId,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error adding to favorites: $e');
      rethrow;
    }
  }

  static Future<void> removeFromFavorites(String productId) async {
    try {
      await client
          .from('favorites')
          .delete()
          .eq('user_id', currentUser!.id)
          .eq('product_id', productId);
    } catch (e) {
      print('Error removing from favorites: $e');
      rethrow;
    }
  }

  static Future<List<ProductModel>> getFavorites() async {
    try {
      final response = await client
          .from('favorites')
          .select('*, products(*)')
          .eq('user_id', currentUser!.id)
          .order('created_at', ascending: false);

      final List<ProductModel> products = [];
      for (var item in response) {
        products.add(ProductModel.fromJson(item['products'] ?? {}));
      }
      return products;
    } catch (e) {
      print('Error fetching favorites: $e');
      return [];
    }
  }

  static Future<bool> isFavorite(String productId) async {
    try {
      final response = await client
          .from('favorites')
          .select('id')
          .eq('user_id', currentUser!.id)
          .eq('product_id', productId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      print('Error checking favorite: $e');
      return false;
    }
  }
}
