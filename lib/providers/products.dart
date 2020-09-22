import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../utils/config_api.dart';

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
    final url = '${Config.URL_BASE}/products.json';

    http
        .post(
      url,
      body: json.encode({
        'title': newproduct.title,
        'description': newproduct.description,
        'price': newproduct.price,
        'imageUrl': newproduct.imageUrl,
        'isFavorite': newproduct.isFavorite,
      }),
    )
        .then((response) {
      _items.add(Product(
        id: json.decode(response.body)['name'],
        title: newproduct.title,
        description: newproduct.description,
        price: newproduct.price,
        imageUrl: newproduct.imageUrl,
      ));
      notifyListeners();
    });
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
