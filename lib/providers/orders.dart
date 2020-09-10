import 'dart:math';

import 'package:flutter/cupertino.dart';

import './order.dart';
import './cart.dart';

// provider para pedido
class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(Cart cart) {
    _orders.insert(
        0,
        Order(
          id: Random().nextDouble().toString(),
          total: cart.totalAmount,
          products: cart.items.values.toList(),
          date: DateTime.now(),
        ));

    notifyListeners();
  }
}
