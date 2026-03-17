import 'package:flutter/foundation.dart';

class AddressModel {
  final String id;
  final String title;
  final String subtitle;
  final double lat;
  final double lon;
  final String type; // 'Home', 'Work', 'Other'
  final String? receiverName;
  final String? phone;

  AddressModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lat,
    required this.lon,
    this.type = 'Other',
    this.receiverName,
    this.phone,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    String displayName = json['display_name'] ?? '';
    List<String> parts = displayName.split(',');

    String title = parts.isNotEmpty ? parts.first.trim() : 'Unknown';
    String subtitle = parts.length > 1
        ? parts.skip(1).join(',').trim()
        : displayName;

    return AddressModel(
      id:
          json['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      subtitle: subtitle,
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      lon: double.tryParse(json['lon'].toString()) ?? 0.0,
      type: json['type'] ?? 'Other',
      receiverName: json['receiverName'],
      phone: json['phone'],
    );
  }

  AddressModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    double? lat,
    double? lon,
    String? type,
    String? receiverName,
    String? phone,
  }) {
    return AddressModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      type: type ?? this.type,
      receiverName: receiverName ?? this.receiverName,
      phone: phone ?? this.phone,
    );
  }
}

// Global state for currently selected address
final currentAddressNotifier = ValueNotifier<AddressModel>(
  AddressModel(
    id: '1',
    title: 'Hallmark Business Plaza',
    subtitle: 'Sant Dnyaneshwar Nagar, Bandra East, Mumbai',
    lat: 19.0596,
    lon: 72.8464,
    type: 'Work',
  ),
);

// Global state for saved addresses
final savedAddressesNotifier = ValueNotifier<List<AddressModel>>([
  AddressModel(
    id: '1',
    title: 'Home',
    subtitle:
        'Bzsn, Peninsula Plaza, Off New Link Road, Veera Desai Industrial Estate, Andheri West',
    lat: 19.1334,
    lon: 72.8333,
    type: 'Home',
    receiverName: 'Nishant',
    phone: '9137173246',
  ),
]);
