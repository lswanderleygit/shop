import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/views/product_detail_screen.dart';
import 'utils/app_routes.dart';

import './views/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
        });
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Minha Loja')),
      ),
      body: Center(
        child: Text('Vamos desenvolver uma loja?'),
      ),
    );
  }
}
