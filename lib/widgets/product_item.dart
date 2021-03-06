import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exceptions/http_exceptions.dart';
import '../providers/products.dart';
import '../utils/app_routes.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
        ),
        title: Text(product.title),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_FORM,
                    arguments: product,
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Tem certeza?'),
                      content: Text('Você quer deletar esse produto?'),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                            // Provider.of<Products>(context, listen: false)
                            //     .deleteProduct(product.id);
                          },
                          child: Text('Sim'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text('Não'),
                        )
                      ],
                    ),
                  ).then((value) async {
                    if (value) {
                      try {
                        await Provider.of<Products>(context, listen: false)
                            .deleteProduct(product.id);
                      } on HttpException catch (error) {
                        scaffold.showSnackBar(
                          SnackBar(
                            content: Text(error.toString()),
                          ),
                        );
                      }
                    }
                  });
                },
              )
            ],
          ),
        ));
  }
}
