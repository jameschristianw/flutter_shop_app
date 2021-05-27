import 'package:flutter/foundation.dart';
import 'package:shop_app/models/cart.dart';

class Orders {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Orders({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}
