import 'package:flutter/foundation.dart';
import 'app_data.dart';

class CartManager extends ChangeNotifier {
  static final CartManager instance = CartManager._internal();
  factory CartManager() => instance;
  CartManager._internal();

  final Map<Dish, int> items = {};
  Restaurant? currentRestaurant;

  void updateQuantity(Dish dish, int delta, Restaurant restaurant) {
    if (currentRestaurant != null && currentRestaurant != restaurant) {
      clear();
    }
    currentRestaurant = restaurant;

    final current = items[dish] ?? 0;
    final next = current + delta;
    if (next <= 0) {
      items.remove(dish);
    } else {
      items[dish] = next;
    }

    if (items.isEmpty) {
      currentRestaurant = null;
    }
    notifyListeners();
  }

  void clear() {
    items.clear();
    currentRestaurant = null;
    notifyListeners();
  }

  double get totalBill {
    double total = 0;
    items.forEach((dish, quantity) {
      total += dish.price * quantity;
    });
    return total;
  }

  int get totalItems {
    int total = 0;
    for (var quantity in items.values) {
      total += quantity;
    }
    return total;
  }
}

final cartManager = CartManager.instance;
