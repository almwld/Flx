import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get supabasePublishableKey => dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '';
  static String get supabaseSecretKey => dotenv.env['SUPABASE_SECRET_KEY'] ?? '';
  static String get mapApiKey => dotenv.env['MAP_API_KEY'] ?? '';

  static bool get isSupabaseConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  static bool get isMapConfigured => mapApiKey.isNotEmpty;

  static void printConfigStatus() {
    print('🔑 Supabase URL: ${isSupabaseConfigured ? "✅" : "❌"}');
    print('🗺️ Map API Key: ${isMapConfigured ? "✅" : "❌"}');
  }
}
