import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
    );
  }
}
