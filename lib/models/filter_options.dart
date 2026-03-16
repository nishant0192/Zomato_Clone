class FilterOptions {
  String sortBy;
  bool nearAndFast;
  bool isScheduled;
  double? minRating;
  int? maxDeliveryTime;
  List<String> activeOffers;
  bool isPureVeg;

  // Additional logic placeholders
  String? dishPriceRange; // 'Under 200', '200-350', 'Above 350'
  List<String> collections;

  FilterOptions({
    this.sortBy = 'Relevance',
    this.nearAndFast = false,
    this.isScheduled = false,
    this.minRating,
    this.maxDeliveryTime,
    this.activeOffers = const [],
    this.isPureVeg = false,
    this.dishPriceRange,
    this.collections = const [],
  });

  FilterOptions copyWith({
    String? sortBy,
    bool? nearAndFast,
    bool? isScheduled,
    double? minRating,
    int? maxDeliveryTime,
    List<String>? activeOffers,
    bool? isPureVeg,
    String? dishPriceRange,
    List<String>? collections,
  }) {
    return FilterOptions(
      sortBy: sortBy ?? this.sortBy,
      nearAndFast: nearAndFast ?? this.nearAndFast,
      isScheduled: isScheduled ?? this.isScheduled,
      minRating: minRating ?? this.minRating,
      maxDeliveryTime: maxDeliveryTime ?? this.maxDeliveryTime,
      activeOffers: activeOffers ?? this.activeOffers,
      isPureVeg: isPureVeg ?? this.isPureVeg,
      dishPriceRange: dishPriceRange ?? this.dishPriceRange,
      collections: collections ?? this.collections,
    );
  }
}
