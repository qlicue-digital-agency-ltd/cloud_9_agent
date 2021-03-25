
import 'package:cloud_9_agent/components/cards/item_card.dart';
import 'package:cloud_9_agent/components/tiles/no_item_tile.dart';
import 'package:cloud_9_agent/constants/constants.dart';
import 'package:cloud_9_agent/provider/product_provider.dart';

import 'package:cloud_9_agent/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final FocusNode _searchFocusNode = FocusNode();

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);

    Future<void> _getData() async {
      _productProvider.fetchProducts();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Products',
            style: TextStyle(color: Colors.white),
          ),
        
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () => Navigator.push(
        //         context, MaterialPageRoute(builder: (_) => CartScreen())),
        //     icon: Badge(
        //       showBadge: _productProvider.totalCartQuantity > 0 ? true : false,
        //       badgeContent: Text(
        //         _productProvider.totalCartQuantity.toString(),
        //         style: TextStyle(color: Colors.white),
        //       ),
        //       child: Icon(
        //         Icons.shopping_cart,
        //         size: 30,
        //         color: Colors.white,
        //       ),
        //       badgeColor: Colors.red,
        //     ),
        //   ),
        //   SizedBox(width: 10)
        // ],
       
       
        bottom: PreferredSize(
            child: Card(
                child: TextField(
              onTap: () {
                print('object');

                
                _productProvider.setOriginalProducts =
                    _productProvider.availableProducts;
              },
              onChanged: (value) {
                _productProvider.filteredProducts(searching: value);
              },
              focusNode: _searchFocusNode,
              controller: _searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                FontAwesomeIcons.search,
                size: 22.0,
                color: Colors.blue,
              )),
            )),
            preferredSize: Size(double.infinity, 50)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            child: _productProvider.isFetchingProductData
                ? Center(child: CircularProgressIndicator())
                : _productProvider.availableProducts.isEmpty
                    ? Center(
                        child: NoItemTile(
                            icon: 'assets/icons/product.png',
                            title: 'No Products',
                            subtitle: 'We are out of stock'),
                      )
                    : RefreshIndicator(
                        child: GridView.builder(
                              itemCount:
                                  _productProvider.availableProducts.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: kDefaultPaddin,
                                crossAxisSpacing: kDefaultPaddin,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) => ItemCard(
                                    product: _productProvider
                                        .availableProducts[index],
                                    press: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                            product: _productProvider
                                                .availableProducts[index],
                                          ),
                                        )),
                                  )),
                        
                        onRefresh: _getData)),
      ),
    );
  }
}
