import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/productProvider.dart';
import 'package:shop_app/screens/editProductScreen.dart';
import 'package:shop_app/widgets/appDrawer.dart';
import 'package:shop_app/widgets/userProductItem.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/user-product-screen';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                id: productsData.items.elementAt(index).id,
                title: productsData.items.elementAt(index).title,
                imageUrl: productsData.items.elementAt(index).imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
