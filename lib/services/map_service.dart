import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class LocationData {
  final double latitude;
  final double longitude;
  final String? address;
  final String? city;
  final String? country;

  LocationData({
    required this.latitude,
    required this.longitude,
    this.address,
    this.city,
    this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'country': country,
    };
  }

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      address: json['address'],
      city: json['city'],
      country: json['country'],
    );
  }
}

class MapService {
  static String get apiKey => AppConfig.mapApiKey;
  static const String _nominatimUrl = 'https://nominatim.openstreetmap.org';

  // الحصول على عنوان من الإحداثيات (Reverse Geocoding)
  static Future<LocationData?> getAddressFromCoordinates(double lat, double lon) async {
    try {
      final url = '$_nominatimUrl/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1';
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'FlexYemen/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];
        
        return LocationData(
          latitude: lat,
          longitude: lon,
          address: data['display_name'],
          city: address['city'] ?? address['town'] ?? address['village'],
          country: address['country'],
        );
      }
      return null;
    } catch (e) {
      print('Error reverse geocoding: $e');
      return null;
    }
  }

  // البحث عن موقع (Forward Geocoding)
  static Future<List<LocationData>> searchLocation(String query) async {
    try {
      final url = '$_nominatimUrl/search?format=json&q=$query&limit=10';
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'FlexYemen/1.0'},
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((item) {
          return LocationData(
            latitude: double.parse(item['lat']),
            longitude: double.parse(item['lon']),
            address: item['display_name'],
          );
        }).toList();
      }
      return [];
    } catch (e) {
      print('Error searching location: $e');
      return [];
    }
  }

  // الحصول على الإعلانات القريبة من قاعدة البيانات
  static Future<List<Map<String, dynamic>>> getNearbyAds(
    double lat, 
    double lon, 
    double radiusKm
  ) async {
    // هذا سيتم ربطه مع Supabase لاحقاً
    // سنقوم بإنشاء دالة في Supabase لحساب المسافة
    return [];
  }

  // بناء رابط خريطة ثابتة
  static String getStaticMapUrl(double lat, double lon, int zoom) {
    return 'https://tile.openstreetmap.org/$zoom/${(lon).toInt()}/${(lat).toInt()}.png';
  }

  // بناء رابط OpenStreetMap للعرض
  static String getMapUrl(double lat, double lon, int zoom) {
    return 'https://www.openstreetmap.org/?mlat=$lat&mlon=$lon#map=$zoom/$lat/$lon';
  }
}
