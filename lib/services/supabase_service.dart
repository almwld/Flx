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
      var filterQuery = client.from('products').select('*, profiles!products_seller_id_fkey(*)');

      if (category != null && category.isNotEmpty && category != 'الكل') {
        filterQuery = filterQuery.eq('category', category);
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        filterQuery = filterQuery.ilike('title', '%$searchQuery%');
      }

      if (minPrice != null) {
        filterQuery = filterQuery.gte('price', minPrice);
      }

      if (maxPrice != null) {
        filterQuery = filterQuery.lte('price', maxPrice);
      }

      final response = await filterQuery.order(sortBy, ascending: ascending);

      return (response as List).map((json) {
        final sellerData = json['profiles'] ?? {};
        return ProductModel.fromJson({
          ...json,
          'seller_name': sellerData['full_name'] ?? 'متجر غير معروف',
          'seller_rating': sellerData['rating'] ?? 0.0,
          'seller_avatar': sellerData['avatar_url'],
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
          .single();

      final sellerData = response['profiles'] ?? {};
      return ProductModel.fromJson({
        ...response,
        'seller_name': sellerData['full_name'] ?? 'متجر غير معروف',
        'seller_rating': sellerData['rating'] ?? 0.0,
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

      return (response as List).map((json) {
        final sellerData = json['profiles'] ?? {};
        return ProductModel.fromJson({
          ...json,
          'seller_name': sellerData['full_name'] ?? 'متجر غير معروف',
          'seller_rating': sellerData['rating'] ?? 0.0,
        });
      }).toList();
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

      return (response as List).map((json) {
        final sellerData = json['profiles'] ?? {};
        return ProductModel.fromJson({
          ...json,
          'seller_name': sellerData['full_name'] ?? 'متجر غير معروف',
          'seller_rating': sellerData['rating'] ?? 0.0,
        });
      }).toList();
    } catch (e) {
      print('Error fetching latest products: $e');
      return [];
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

  static Future<void> updateProduct(String id, Map<String, dynamic> productData) async {
    try {
      await client.from('products').update(productData).eq('id', id);
    } catch (e) {
      print('Error updating product: $e');
      rethrow;
    }
  }

  static Future<void> deleteProduct(String id) async {
    try {
      await client.from('products').delete().eq('id', id);
    } catch (e) {
      print('Error deleting product: $e');
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

  static Future<double> getProductAverageRating(String productId) async {
    try {
      final response = await client
          .from('ratings')
          .select('rating')
          .eq('product_id', productId);

      if (response.isEmpty) return 0.0;
      
      final ratings = (response as List).map((r) => (r['rating'] as num).toDouble()).toList();
      final average = ratings.reduce((a, b) => a + b) / ratings.length;
      return double.parse(average.toStringAsFixed(1));
    } catch (e) {
      print('Error calculating average rating: $e');
      return 0.0;
    }
  }

  static Future<int> getProductRatingsCount(String productId) async {
    try {
      final response = await client
          .from('ratings')
          .select('id')
          .eq('product_id', productId);

      return response.length;
    } catch (e) {
      print('Error counting ratings: $e');
      return 0;
    }
  }

  static Future<bool> addRating({
    required String productId,
    required double rating,
    String? comment,
    List<String>? images,
  }) async {
    if (!isAuthenticated) return false;

    try {
      await client.from('ratings').insert({
        'product_id': productId,
        'user_id': currentUser!.id,
        'rating': rating,
        'comment': comment,
        'images': images,
        'created_at': DateTime.now().toIso8601String(),
      });

      await _updateProductAverageRating(productId);
      return true;
    } catch (e) {
      print('Error adding rating: $e');
      return false;
    }
  }

  static Future<bool> updateRating(String ratingId, {
    double? rating,
    String? comment,
    List<String>? images,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (rating != null) updates['rating'] = rating;
      if (comment != null) updates['comment'] = comment;
      if (images != null) updates['images'] = images;
      updates['updated_at'] = DateTime.now().toIso8601String();

      await client.from('ratings').update(updates).eq('id', ratingId);
      return true;
    } catch (e) {
      print('Error updating rating: $e');
      return false;
    }
  }

  static Future<bool> deleteRating(String ratingId) async {
    try {
      await client.from('ratings').delete().eq('id', ratingId);
      return true;
    } catch (e) {
      print('Error deleting rating: $e');
      return false;
    }
  }

  static Future<RatingModel?> getUserRatingForProduct(String productId) async {
    if (!isAuthenticated) return null;

    try {
      final response = await client
          .from('ratings')
          .select('*, profiles!ratings_user_id_fkey(*)')
          .eq('product_id', productId)
          .eq('user_id', currentUser!.id)
          .maybeSingle();

      if (response == null) return null;

      return RatingModel.fromJson({
        ...response,
        'user_name': response['profiles']?['full_name'],
        'user_avatar': response['profiles']?['avatar_url'],
      });
    } catch (e) {
      print('Error fetching user rating: $e');
      return null;
    }
  }

  static Future<void> _updateProductAverageRating(String productId) async {
    try {
      final avg = await getProductAverageRating(productId);
      final count = await getProductRatingsCount(productId);
      
      await client
          .from('products')
          .update({
            'rating': avg,
            'review_count': count,
          })
          .eq('id', productId);
    } catch (e) {
      print('Error updating product average rating: $e');
    }
  }
}

  // ==================== رفع الصور إلى Supabase Storage ====================
  static Future<String?> uploadImage({
    required String filePath,
    required String bucket,
    String? fileName,
  }) async {
    try {
      final file = File(filePath);
      final String finalFileName = fileName ?? '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final response = await client.storage.from(bucket).upload(
        finalFileName,
        file,
        fileOptions: const FileOptions(cacheControl: '3600'),
      );
      
      // الحصول على الرابط العام
      final publicUrl = client.storage.from(bucket).getPublicUrl(finalFileName);
      return publicUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // رفع صور متعددة
  static Future<List<String>> uploadMultipleImages({
    required List<String> filePaths,
    required String bucket,
  }) async {
    List<String> urls = [];
    for (String path in filePaths) {
      final url = await uploadImage(filePath: path, bucket: bucket);
      if (url != null) urls.add(url);
    }
    return urls;
  }
