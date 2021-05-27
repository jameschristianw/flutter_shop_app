import 'package:flutter/foundation.dart';
import 'package:shop_app/models/orders.dart';
import 'package:shop_app/models/cart.dart';

class OrderProvider with ChangeNotifier {
  List<Orders> _orders = [];

  List<Orders> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      Orders(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
