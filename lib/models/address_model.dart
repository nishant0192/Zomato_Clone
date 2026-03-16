import 'package:flutter/foundation.dart';

class AddressModel {
  final String title;
  final String subtitle;
  final double lat;
  final double lon;

  AddressModel({
    required this.title,
    required this.subtitle,
    required this.lat,
    required this.lon,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    String displayName = json['display_name'] ?? '';
    List<String> parts = displayName.split(',');

    String title = parts.isNotEmpty ? parts.first.trim() : 'Unknown';
    String subtitle = parts.length > 1
        ? parts.skip(1).join(',').trim()
        : displayName;

    return AddressModel(
      title: title,
      subtitle: subtitle,
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      lon: double.tryParse(json['lon'].toString()) ?? 0.0,
    );
  }
}

// Global state for currently selected address
final currentAddressNotifier = ValueNotifier<AddressModel>(
  AddressModel(
    title: 'Hallmark Business Plaza',
    subtitle: 'Sant Dnyaneshwar Nagar, Bandra East, Mumbai',
    lat: 19.0596,
    lon: 72.8464,
  ),
);
