import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class Auth with ChangeNotifier {
  static const _url =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${Constants.WEB_KEY_API}";
  Future<void> signup(String email, String password) async {
    final response = await http.post(
      _url,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": "true",
      }),
    );

    print(json.decode(response.body));
    return Future.value();
  }
}
