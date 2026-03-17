import '../config/app_config.dart';

class MapService {
  static String get apiKey => AppConfig.mapApiKey;

  static String buildStaticMapUrl(double lat, double lon, int zoom) {
    return 'https://tile.openstreetmap.org/$zoom/${lon.toInt()}/${lat.toInt()}.png';
  }

  static bool get isConfigured => AppConfig.isMapConfigured;
}
