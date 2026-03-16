class Restaurant {
  final String name;
  final String imageUrl;
  final double rating;
  final String time;
  final String offer;
  final bool isPromoted;
  final bool isVeg;

  const Restaurant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.time,
    required this.offer,
    this.isPromoted = false,
    this.isVeg = false,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      time: json['time'] as String,
      offer: json['offer'] as String,
      isPromoted: json['isPromoted'] as bool? ?? false,
      isVeg: json['isVeg'] as bool? ?? false,
    );
  }
}

class Category {
  final String name;
  final String imageUrl;
  final String? promoUrl;

  const Category({required this.name, required this.imageUrl, this.promoUrl});
}
