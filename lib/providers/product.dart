import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../exceptions/http_exceptions.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    _toggleFavorite();

    final url =
        "${Constants.BASE_API_URL}/userFavorites/$userId/$id.json?auth=$token";

    final response = await http.put(
      url,
      body: json.encode(isFavorite),
    );

    if (response.statusCode >= 400) {
      _toggleFavorite();
      throw HttpException('Ocorreu um erro ao favoritar o produto.');
    }
  }
}
