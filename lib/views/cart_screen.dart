import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item_widget.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      'R\$${cart.totalAmount.toString()}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  OrderButtoon(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, index) => CartItemWidget(cartItems[index]),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButtoon extends StatefulWidget {
  const OrderButtoon({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtoonState createState() => _OrderButtoonState();
}

class _OrderButtoonState extends State<OrderButtoon> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: _isLoading ? CircularProgressIndicator() : Text('COMPRAR'),
        textColor: Theme.of(context).primaryColor,
        onPressed: widget.cart.totalAmount == 0
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false)
                    .addOrder(widget.cart);

                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              });
  }
}
