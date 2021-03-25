import 'package:cloud_9_agent/components/text-fields/label_text_field.dart';
import 'package:cloud_9_agent/components/text-fields/mobile_number.dart';
import 'package:cloud_9_agent/constants/constants.dart';
import 'package:cloud_9_agent/models/product.dart';
import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:cloud_9_agent/provider/order_provider.dart';
import 'package:cloud_9_agent/provider/client_provider.dart';
import 'package:cloud_9_agent/screens/order_detail_screen.dart';
import 'package:cloud_9_agent/models/customer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  AddToCart({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();

  Client selectedClient;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _mobileTextEditingController = TextEditingController();
  TextEditingController _codeTextController = TextEditingController();


  bool _isPaying = false;

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _orderProvider = Provider.of<OrderProvider>(context);
    final _clientProvider = Provider.of<ClientProvider>(context);

    if(_clientProvider.clients.isNotEmpty) selectedClient = _clientProvider.clients.first;

    Future<void> _showDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Phone Number to Pay'),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: ListBody(
                        children: <Widget>[
                          DropdownButton(
                            value: selectedClient,
                            items: _clientProvider.clients.map((
                              client) =>
                              DropdownMenuItem<Client>(
                                value: client,
                                child: Text(client.fullName),
                                )
                          ).toList(),
                            onChanged: (Client selected){
                            selectedClient = selected;
                            },
                          ),
                          // MobileTextfield(
                          //     hitText: 'Phone Number',
                          //     labelText: 'Phone Number',
                          //     focusNode: _mobileFocusNode,
                          //     textEditingController: _mobileTextEditingController,
                          //     maxLines: 1,
                          //     message: 'Phone number required',
                          //     onCodeChange: (country) {
                          //       print(country);
                          //       _orderProvider.setSelectedCountry = country;
                          //     },
                          //     selectedCountry: _orderProvider.selectedCountry,
                          //     keyboardType: TextInputType.number),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FlatButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: FlatButton(
                                  textColor: Colors.white,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  child: _isPaying
                                      ? CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                      : Text('Pay'.toUpperCase()),
                                  onPressed: () {

                                    if (selectedClient != null) {
                                      setState(() {
                                        _isPaying = true;
                                      });
                                      _orderProvider
                                          .createOrder(
                                          userId:selectedClient.id,
                                          paymentPhone: selectedClient.phone,
                                          noOfItems: 1,
                                          orderableId: widget.product.id,
                                          orderableType: 'Product',
                                          amount: widget.product.price,
                                          agentCode: _authProvider.authenticatedUser.code)
                                          .then((hasError) {
                                        setState(() {
                                          _isPaying = false;
                                        });
                                        if (hasError) {

                                        } else {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderDetailScreen()));
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.blue,
                onPressed: () {
                  _showDialog();
                },
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
