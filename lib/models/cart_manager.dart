import 'package:flutter/foundation.dart';
import 'app_data.dart';

class CartManager extends ChangeNotifier {
  static final CartManager instance = CartManager._internal();
  factory CartManager() => instance;
  CartManager._internal();

  final Map<Dish, int> items = {};
  Restaurant? currentRestaurant;

  void updateQuantity(Dish dish, int delta, Restaurant restaurant) {
    if (currentRestaurant == null) {
      currentRestaurant = restaurant;
    }

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

  double get subTotal {
    double total = 0;
    items.forEach((dish, quantity) {
      total += dish.price * quantity;
    });
    return total;
  }

  double get gst => subTotal * 0.05; // 5% GST
  double get deliveryCharge => 30.0;
  double get platformFee => 5.0;
  double get discountAmount => 45.0; // Hardcoded discount

  double get totalBill {
    if (items.isEmpty) return 0;
    return subTotal + gst + deliveryCharge + platformFee - discountAmount;
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
