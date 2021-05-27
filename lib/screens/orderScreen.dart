import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orderProvider.dart';
import 'package:shop_app/widgets/appDrawer.dart';
import 'package:shop_app/widgets/orderItem.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItem(
          order: ordersData.orders.elementAt(index),
        ),
        itemCount: ordersData.orders.length,
      ),
      drawer: AppDrawer(),
    );
  }
}
