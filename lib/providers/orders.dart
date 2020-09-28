import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../utils/constants.dart';
import './order.dart';
import './cart.dart';

// provider para pedido
class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    const url = "$BASE_URL/orders.json";
    final date = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        "total": cart.totalAmount,
        "date": date.toIso8601String(),
        "products": cart.items.values
            .map((cartItem) => {
                  "id": cartItem.id,
                  "title": cartItem.title,
                  "quantity": cartItem.quantity,
                  "price": cartItem.price,
                })
            .toList()
      }),
    );

    _items.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          total: cart.totalAmount,
          products: cart.items.values.toList(),
          date: date,
        ));

    notifyListeners();
  }
}
