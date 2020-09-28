import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../utils/constants.dart';
import './order.dart';
import './cart.dart';
import './item_cart.dart';

// provider para pedido
class Orders with ChangeNotifier {
  static const _url = Constants.BASE_API_URL;

  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];
    final response = await http.get("$_url/orders.json");
    Map<String, dynamic> data = json.decode(response.body);

    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(Order(
          id: orderId,
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              title: item['title'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
          date: DateTime.parse(orderData['date']),
        ));
      });
      _items = loadedItems.reversed.toList();
      notifyListeners();
    }

    // return Future.value();
  }

  Future<void> addOrder(Cart cart) async {
    const url = "$_url/orders.json";
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
