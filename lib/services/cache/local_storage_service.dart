import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String _settingsBox = 'settings';
  static const String _cacheBox = 'cache';
  static const String _favoritesBox = 'favorites';
  static const String _userBox = 'user';

  static late Box<dynamic> _settings;
  static late Box<dynamic> _cache;
  static late Box<dynamic> _favorites;
  static late Box<dynamic> _user;

  // تهيئة Hive
  static Future<void> initialize() async {
    await Hive.initFlutter();
    
    _settings = await Hive.openBox(_settingsBox);
    _cache = await Hive.openBox(_cacheBox);
    _favorites = await Hive.openBox(_favoritesBox);
    _user = await Hive.openBox(_userBox);
  }

  // ==================== الإعدادات ====================

  static Future<void> setSetting(String key, dynamic value) async {
    await _settings.put(key, value);
  }

  static dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settings.get(key, defaultValue: defaultValue);
  }

  static Future<void> removeSetting(String key) async {
    await _settings.delete(key);
  }

  // ==================== الكاش ====================

  static Future<void> setCache(String key, dynamic value) async {
    await _cache.put(key, {
      'data': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static dynamic getCache(String key, {int maxAgeMinutes = 60}) {
    final cached = _cache.get(key);
    if (cached == null) return null;

    final timestamp = cached['timestamp'] as int;
    final age = DateTime.now().millisecondsSinceEpoch - timestamp;
    final maxAge = maxAgeMinutes * 60 * 1000;

    if (age > maxAge) {
      _cache.delete(key);
      return null;
    }

    return cached['data'];
  }

  static Future<void> clearCache() async {
    await _cache.clear();
  }

  // ==================== المفضلة (Offline) ====================

  static Future<void> addToFavorites(String adId) async {
    final favorites = getFavorites();
    if (!favorites.contains(adId)) {
      favorites.add(adId);
      await _favorites.put('favorites_list', favorites);
    }
  }

  static Future<void> removeFromFavorites(String adId) async {
    final favorites = getFavorites();
    favorites.remove(adId);
    await _favorites.put('favorites_list', favorites);
  }

  static List<String> getFavorites() {
    return List<String>.from(_favorites.get('favorites_list', defaultValue: []));
  }

  static bool isFavorite(String adId) {
    return getFavorites().contains(adId);
  }

  // ==================== بيانات المستخدم ====================

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _user.put('user_data', userData);
  }

  static Map<String, dynamic>? getUserData() {
    return _user.get('user_data') as Map<String, dynamic>?;
  }

  static Future<void> clearUserData() async {
    await _user.clear();
  }

  // ==================== مساعدات عامة ====================

  static Future<void> clearAll() async {
    await _settings.clear();
    await _cache.clear();
    await _favorites.clear();
    await _user.clear();
  }
}

  // حفظ الصور محلياً (تخزين مساراتها)
  static Future<void> cacheImage(String url, String localPath) async {
    // يمكن استخدام flutter_downloader أو dio لتنزيل الصورة
    // هذا مثال بسيط باستخدام NetworkImage لتحميلها إلى الذاكرة
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/${url.hashCode}.jpg');
      if (!await file.exists()) {
        final response = await HttpClient().getUrl(Uri.parse(url));
        final downloadedFile = await response.close();
        await downloadedFile.pipe(file.openWrite());
      }
    } catch (e) {
      print('Error caching image: $e');
    }
  }
