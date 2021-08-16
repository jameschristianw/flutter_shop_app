import 'package:flutter/material.dart';
import 'package:shop_app/screens/orderScreen.dart';
import 'package:shop_app/screens/userProductScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello World!'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pop();
              if (ModalRoute.of(context).settings.name != '/') {
                Navigator.of(context).pushReplacementNamed('/');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pop();
              if (ModalRoute.of(context).settings.name !=
                  OrderScreen.routeName) {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Product'),
            onTap: () {
              Navigator.of(context).pop();
              if (ModalRoute.of(context).settings.name !=
                  UserProductScreen.routeName) {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductScreen.routeName);
              }
            },
          )
        ],
      ),
    );
  }
}
