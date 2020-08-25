import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = DUMMY_PRODUCTS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Minha Loja'),
        ),
      ),
      body: GridView.builder(
        itemCount: loadedProducts.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (ctx, index) => ProductItem(loadedProducts[index]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
