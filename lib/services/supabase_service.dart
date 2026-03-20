import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';
import '../models/product_model.dart';
import '../models/rating_model.dart';

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

  static Future<void> resetPassword(String email) async {
    try {
      await client.auth.resetPasswordForEmail(email);
    } catch (e) {
      print('Error resetting password: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      return response;
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  static Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await client.from('profiles').update(data).eq('id', userId);
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }

  // ==================== المنتجات ====================
  static Future<List<ProductModel>> getProducts({
    String? category,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    String sortBy = 'created_at',
    bool ascending = false,
  }) async {
    try {
      var query = client.from('products').select('*, profiles!products_seller_id_fkey(*)');

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

      final response = await query.order(sortBy, ascending: ascending);

      return (response as List).map((json) {
        final sellerData = json['profiles'] ?? {};
        return ProductModel.fromJson({
          ...json,
          'seller_name': sellerData['full_name'] ?? 'متجر غير معروف',
          'seller_rating': sellerData['rating'] ?? 0.0,
        });
      }).toList();
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
          .maybeSingle();

      if (response == null) return null;
      final sellerData = response['profiles'] ?? {};
      return ProductModel.fromJson({
        ...response,
        'seller_name': sellerData['full_name'] ?? 'متجر غير معروف',
        'seller_rating': sellerData['rating'] ?? 0.0,
      });
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }

  static Future<List<ProductModel>> getSellerProducts(String sellerId) async {
    try {
      final response = await client
          .from('products')
          .select('*')
          .eq('seller_id', sellerId)
          .order('created_at', ascending: false);

      return (response as List).map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching seller products: $e');
      return [];
    }
  }

  static Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await client.from('products').insert({
        ...productData,
        'seller_id': currentUser!.id,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error adding product: $e');
      rethrow;
    }
  }

  // ==================== الطلبات ====================
  static Future<void> createOrder(Map<String, dynamic> orderData) async {
    try {
      await client.from('orders').insert({
        ...orderData,
        'user_id': currentUser!.id,
        'created_at': DateTime.now().toIso8601String(),
        'status': 'pending',
      });
    } catch (e) {
      print('Error creating order: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getUserOrders() async {
    try {
      final response = await client
          .from('orders')
          .select('*, order_items(*)')
          .eq('user_id', currentUser!.id)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching orders: $e');
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

      return (response as List).map((json) {
        return ProductModel.fromJson(json['products'] ?? {});
      }).toList();
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

  // ==================== التقييمات ====================
  static Future<List<RatingModel>> getProductRatings(String productId) async {
    try {
      final response = await client
          .from('ratings')
          .select('*, profiles!ratings_user_id_fkey(*)')
          .eq('product_id', productId)
          .order('created_at', ascending: false);

      return (response as List).map((json) {
        return RatingModel.fromJson({
          ...json,
          'user_name': json['profiles']?['full_name'],
          'user_avatar': json['profiles']?['avatar_url'],
        });
      }).toList();
    } catch (e) {
      print('Error fetching ratings: $e');
      return [];
    }
  }

  static Future<bool> addRating({
    required String productId,
    required double rating,
    String? comment,
  }) async {
    if (!isAuthenticated) return false;

    try {
      await client.from('ratings').insert({
        'product_id': productId,
        'user_id': currentUser!.id,
        'rating': rating,
        'comment': comment,
        'created_at': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print('Error adding rating: $e');
      return false;
    }
  }

  // ==================== رفع الصور ====================
  static Future<String?> uploadImage({
    required String filePath,
    required String bucket,
    String? fileName,
  }) async {
    try {
      final file = File(filePath);
      final String finalFileName = fileName ?? '${DateTime.now().millisecondsSinceEpoch}.jpg';
      await client.storage.from(bucket).upload(
        finalFileName,
        file,
        fileOptions: const FileOptions(cacheControl: '3600'),
      );
      return client.storage.from(bucket).getPublicUrl(finalFileName);
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
