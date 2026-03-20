import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationData {
  final double latitude; final double longitude; final String? address; final String? city; final String? country;
  LocationData({required this.latitude, required this.longitude, this.address, this.city, this.country});
  Map<String, dynamic> toJson() => {'latitude': latitude, 'longitude': longitude, 'address': address, 'city': city, 'country': country};
}

class MapService {
  static const String _nominatimUrl = 'https://nominatim.openstreetmap.org';

  static Future<LocationData?> getAddressFromCoordinates(double lat, double lon) async {
    try {
      final url = '$_nominatimUrl/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1';
      final response = await http.get(Uri.parse(url), headers: {'User-Agent': 'FlexYemen/1.0'});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];
        return LocationData(
          latitude: lat, longitude: lon, address: data['display_name'],
          city: address['city'] ?? address['town'] ?? address['village'], country: address['country'],
        );
      }
      return null;
    } catch (e) { return null; }
  }

  static Future<List<LocationData>> searchLocation(String query) async {
    try {
      final url = '$_nominatimUrl/search?format=json&q=$query&limit=10';
      final response = await http.get(Uri.parse(url), headers: {'User-Agent': 'FlexYemen/1.0'});
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((item) => LocationData(
          latitude: double.parse(item['lat']), longitude: double.parse(item['lon']), address: item['display_name'],
        )).toList();
      }
      return [];
    } catch (e) { return []; }
  }
}
