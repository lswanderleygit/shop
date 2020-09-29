import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './utils/app_routes.dart';
import './views/auth_screen.dart';
import './views/products_screen.dart';
import './views/product_detail_screen.dart';
import './views/products_overview_screen.dart';
import './views/product_form_screen.dart';
import './views/cart_screen.dart';
import './views/orders_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Orders(),
        )
      ],
      child: MaterialApp(
          title: 'Minha Loja',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.orange,
            fontFamily: 'Lato',
          ),
          // home: ProductsOverviewScreen(),
          routes: {
            AppRoutes.AUTH: (ctx) => AuthScreen(),
            AppRoutes.HOME: (ctx) => ProductsOverviewScreen(),
            AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
            AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
            AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
            AppRoutes.CART: (ctx) => CartScreen(),
            AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          }),
    );
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
