import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/item_cart.dart';
import 'product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get item {
    return {..._items};
  }

  void add(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existItem) {
        return CartItem(
          id: existItem.id,
          title: existItem.title,
          quantity: existItem.quantity + 1,
          price: existItem.price,
        );
      });
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }
  }
}
