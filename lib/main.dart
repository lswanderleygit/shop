import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './utils/app_routes.dart';
import './views/products_screen.dart';
import './views/product_detail_screen.dart';
import './views/product_form_screen.dart';
import './views/cart_screen.dart';
import './views/orders_screen.dart';
import 'views/auth_home_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (ctx, auth, previousProducts) => new Products(
            auth.token,
            auth.userId,
            previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => new Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (ctx, auth, previousProducts) => new Orders(
            auth.token,
            previousProducts.items,
          ),
        ),
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
            AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
            // AppRoutes.HOME: (ctx) => ProductsOverviewScreen(),
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
