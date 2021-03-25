import 'package:cloud_9_agent/components/body/product_details_body.dart';
import 'package:cloud_9_agent/models/product.dart';
import 'package:flutter/material.dart';

import 'background.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Background(
          screen: Scaffold(
        // each product have a color
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Product Details'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
              
            })
          ],
        ),
        body: Body(product: product),
      ),
    );
  }
}