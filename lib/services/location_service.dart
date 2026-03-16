import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/address_model.dart';

class LocationService {
  // Using OpenStreetMap's Nominatim API (Free, no key required for light usage)
  static const String _baseUrl = 'https://nominatim.openstreetmap.org/search';

  static Future<List<AddressModel>> searchAddress(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final uri = Uri.parse(
        '$_baseUrl?q=${Uri.encodeComponent(query)}&format=json&addressdetails=1&limit=8&countrycodes=in',
      );

      final response = await http.get(
        uri,
        headers: {
          // App-specific user agent is required by Nominatim terms of service
          'User-Agent': 'FlutterZomatoClone/1.0',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => AddressModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching address: $e');
      return [];
    }
  }
}
