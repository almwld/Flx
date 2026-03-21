import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static late Box<dynamic> _settings;
  static late Box<dynamic> _cache;
  static late Box<dynamic> _favorites;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    _settings = await Hive.openBox('settings');
    _cache = await Hive.openBox('cache');
    _favorites = await Hive.openBox('favorites');
  }

  static Future<void> setSetting(String key, dynamic value) async {
    await _settings.put(key, value);
  }

  static dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settings.get(key, defaultValue: defaultValue);
  }

  static Future<void> setCache(String key, dynamic value) async {
    await _cache.put(key, {
      'data': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static dynamic getCache(String key, {int maxAgeMinutes = 60}) {
    final cached = _cache.get(key);
    if (cached == null) return null;
    final age = DateTime.now().millisecondsSinceEpoch - (cached['timestamp'] as int);
    if (age > maxAgeMinutes * 60 * 1000) {
      _cache.delete(key);
      return null;
    }
    return cached['data'];
  }

  static List<String> getFavorites() {
    return List<String>.from(_favorites.get('favorites_list', defaultValue: []));
  }

  static bool isFavorite(String adId) {
    return getFavorites().contains(adId);
  }

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
}
