import 'dart:math';

import 'package:flutter/material.dart';
import 'product.dart';
import '../data/dummy_data.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product newproduct) {
    _items.add(
      Product(
        id: Random().nextDouble().toString(),
        title: newproduct.title,
        description: newproduct.description,
        price: newproduct.price,
        imageUrl: newproduct.imageUrl,
      ),
    );
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final indexProduct = _items.indexWhere((prod) => prod.id == product.id);

    if (indexProduct >= 0) {
      _items[indexProduct] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final indexProduct = _items.indexWhere((prod) => prod.id == id);

    if (indexProduct >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}

// bool _showFavoriteOnly = false;

// List<Product> get items {
//   if (_showFavoriteOnly) {
//     return _items.where((product) => product.isFavorite).toList();
//   }
//   return [..._items];
// }

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }
//
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
