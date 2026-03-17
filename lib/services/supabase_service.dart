import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // ==================== الإعلانات (products) ====================

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await client
        .from('products')
        .select('*, profiles(*)')
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>?> getProduct(String id) async {
    final response = await client
        .from('products')
        .select('*, profiles(*)')
        .eq('id', id)
        .single();
    return response;
  }

  static Future<void> addProduct(Map<String, dynamic> productData) async {
    await client.from('products').insert({
      ...productData,
      'user_id': currentUser!.id,
    });
  }

  static Future<void> updateProduct(String id, Map<String, dynamic> productData) async {
    await client.from('products').update(productData).eq('id', id);
  }

  static Future<void> deleteProduct(String id) async {
    await client.from('products').delete().eq('id', id);
  }

  static Future<List<Map<String, dynamic>>> getUserProducts() async {
    final response = await client
        .from('products')
        .select('*')
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // ==================== المفضلة ====================

  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final response = await client
        .from('favorites')
        .select('*, products(*)')
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> addToFavorites(String productId) async {
    await client.from('favorites').insert({
      'user_id': currentUser!.id,
      'product_id': productId,
    });
  }

  static Future<void> removeFromFavorites(String productId) async {
    await client
        .from('favorites')
        .delete()
        .eq('user_id', currentUser!.id)
        .eq('product_id', productId);
  }

  // ==================== المحفظة ====================

  static Future<Map<String, dynamic>?> getWallet() async {
    final response = await client
        .from('wallets')
        .select('*')
        .eq('user_id', currentUser!.id)
        .maybeSingle();
    return response;
  }

  static Future<void> createWallet() async {
    await client.from('wallets').insert({
      'user_id': currentUser!.id,
      'yer_balance': 0.0,
      'sar_balance': 0.0,
      'usd_balance': 0.0,
    });
  }

  static Future<void> updateBalance(String currency, double amount) async {
    await client.from('wallets').update({
      '${currency.toLowerCase()}_balance': amount,
    }).eq('user_id', currentUser!.id);
  }

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final response = await client
        .from('transactions')
        .select('*')
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> addTransaction(Map<String, dynamic> transactionData) async {
    await client.from('transactions').insert({
      ...transactionData,
      'user_id': currentUser!.id,
    });
  }

  // ==================== الرسائل ====================

  static Future<List<Map<String, dynamic>>> getMessages(String userId) async {
    final response = await client
        .from('internal_messages')
        .select('*')
        .or('sender_id.eq.$userId,receiver_id.eq.$userId')
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> sendMessage(String receiverId, String messageText, {String? productContextId}) async {
    await client.from('internal_messages').insert({
      'sender_id': currentUser!.id,
      'receiver_id': receiverId,
      'message_text': messageText,
      'product_context_id': productContextId,
    });
  }

  // ==================== التقييمات ====================

  static Future<List<Map<String, dynamic>>> getRatings(String productId) async {
    final response = await client
        .from('ratings')
        .select('*')
        .eq('product_id', productId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> addRating(String productId, int stars, {String? comment}) async {
    await client.from('ratings').insert({
      'user_id': currentUser!.id,
      'product_id': productId,
      'stars': stars,
      'comment': comment,
    });
  }

  // ==================== طلبات السحب ====================

  static Future<List<Map<String, dynamic>>> getWithdrawalRequests() async {
    final response = await client
        .from('withdrawal_requests')
        .select('*')
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> requestWithdrawal(double amount, String method, String accountDetails) async {
    await client.from('withdrawal_requests').insert({
      'user_id': currentUser!.id,
      'amount': amount,
      'method': method,
      'account_details': accountDetails,
    });
  }
}
