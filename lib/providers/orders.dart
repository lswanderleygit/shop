import 'dart:math';

import 'package:flutter/cupertino.dart';

import './order.dart';
import './item_cart.dart';

// provider para pedido
class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double total) {
    _orders.insert(
        0,
        Order(
          id: Random().nextDouble().toString(),
          total: total,
          products: products,
          date: DateTime.now(),
        ));

    notifyListeners();
  }
}
