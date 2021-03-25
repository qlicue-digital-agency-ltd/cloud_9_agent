import 'package:cloud_9_agent/constants/constants.dart';
import 'package:cloud_9_agent/models/product.dart';
import 'package:cloud_9_agent/utils/currency_converter.dart';
import 'package:flutter/material.dart';

import 'add_to_cart.dart';
import 'color_and_size.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
        // It provide us total height and width
    //Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Text('Product',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Container(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: Hero(
                    tag: "${product.id}",
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              product.name,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Price\n",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: currencyCovertor.currencyCovertor(
                          amount: product.price),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
            ],
          ),
          Card(
            
            child: Container(
              padding: EdgeInsets.all(8),
                child: Column(
              children: [
                ColorAndSize(product: product),
                SizedBox(height: kDefaultPaddin / 2),
                Description(product: product),
                SizedBox(height: kDefaultPaddin / 2),
                CounterWithFavBtn(
                  product: product,
                ),
                SizedBox(height: kDefaultPaddin / 2),
                AddToCart(product: product)
              ],
            )),
          )
        ],
      ),
    );
  }


}
