import 'package:cloud_9_agent/components/buttons/mno_dropdown.dart';
import 'package:cloud_9_agent/components/text-fields/mobile_number.dart';
import 'package:cloud_9_agent/components/text-fields/rowed_text_field.dart';
import 'package:cloud_9_agent/constants/constants.dart';
import 'package:cloud_9_agent/provider/order_provider.dart';
import 'package:cloud_9_agent/utils/currency_converter.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDetailScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
   final _orderProvider = Provider.of<OrderProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_){
      _orderProvider.getMNOList();
    });


    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(title: Text('Order details')),
        body: _orderProvider.getSelectedOrder.paymentStatus == "null"
            ? CustomScrollView(slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  SizedBox(height: 10),
                  Card(
                    margin: EdgeInsets.only(
                        left: 10, top: 10, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RowedTextField(
                            title: 'Item',
                            subtitle: _orderProvider.getSelectedOrder.product != null ? _orderProvider
                                .getSelectedOrder.product.name : _orderProvider.getSelectedOrder.service.title,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RowedTextField(
                            title: 'Number of Items',
                            subtitle:
                            _orderProvider.getSelectedOrder.noOfItems,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RowedTextField(
                            title: 'Amount',
                            subtitle: currencyCovertor.currencyCovertor(
                              amount: double.parse(
                                  _orderProvider.getSelectedOrder.amount),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () => _showDialog(context,_orderProvider),
                            child: Text('REQUEST USSD QUICK PAY'),
                            color: Colors.green,
                            textColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Or You can complete order by following instructions bellow'),
                        )
                      ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Use Pay Number',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            '8	1	8	1	5	1	3	6',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'USSD Payment Instructions',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MNODropdown(
                            items: _orderProvider.mnoList,
                            onChange: (val) {
                              _orderProvider.setSelectedMNO = val;
                            },
                            title: 'Select MNO',
                            value: _orderProvider.selectedMNO,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ])),
                SliverList(
                    delegate: SliverChildBuilderDelegate((_, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: (index == 0 ? 20 : 0)),
                    child: Material(
                      elevation: 2,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _orderProvider.selectedMNO.instructions[index],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                }, childCount: _orderProvider.selectedMNO.instructions.length)),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Card(
                    margin: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'or Pay by Mastercard QR',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Scan QR and Pay',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: QrImage(
                            data: _orderProvider.getSelectedOrder.qr,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                        SizedBox(height: 40),
                        Divider(
                          indent: 5,
                          endIndent: 5,
                          color: Theme.of(context).primaryColor,
                        ),
                        Center(
                          child: Text(
                            'Order Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Reference',
                                  subtitle:
                                      _orderProvider.getSelectedOrder.reference,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Product',
                                  subtitle: _orderProvider
                                      .getSelectedOrder.product != null ? _orderProvider
                                      .getSelectedOrder.product.name : _orderProvider
                                      .getSelectedOrder.service.title,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Number of Items',
                                  subtitle:
                                      _orderProvider.getSelectedOrder.noOfItems,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Phone',
                                  subtitle: '+' +
                                      _orderProvider
                                          .getSelectedOrder.buyerPhone,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Amount',
                                  subtitle: currencyCovertor.currencyCovertor(
                                    amount: double.parse(
                                        _orderProvider.getSelectedOrder.amount),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Status',
                                  subtitle: _orderProvider
                                              .getSelectedOrder.paymentStatus ==
                                          "null"
                                      ? "Not Paid"
                                      : _orderProvider
                                          .getSelectedOrder.paymentStatus,
                                ),
                              ),
                              Image.asset(
                                'assets/icons/cloud9_transparent_logo.png',
                                width: 80,
                                height: 80,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ])),
              ])
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Reference',
                                subtitle:
                                    _orderProvider.getSelectedOrder.reference,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Product',
                                subtitle: _orderProvider
                                    .getSelectedOrder.product != null ? _orderProvider
                                    .getSelectedOrder.product.name : _orderProvider
                                    .getSelectedOrder.service.title,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Number of Items',
                                subtitle:
                                    _orderProvider.getSelectedOrder.noOfItems,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Phone',
                                subtitle: '+' +
                                    _orderProvider.getSelectedOrder.buyerPhone,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Amount',
                                subtitle: currencyCovertor.currencyCovertor(
                                  amount: double.parse(
                                      _orderProvider.getSelectedOrder.amount),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Status',
                                subtitle: _orderProvider
                                            .getSelectedOrder.paymentStatus ==
                                        "null"
                                    ? "Not Paid"
                                    : _orderProvider
                                        .getSelectedOrder.paymentStatus,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/cloud9_transparent_logo.png',
                              width: 80,
                              height: 80,
                            )
                          ]))
                    ],
                  ),
                ),
              )));
  }

  Future<void> _showDialog(BuildContext context,OrderProvider _orderProvider) async {
    TextEditingController _mobileTextEditingController = TextEditingController();
    final FocusNode _mobileFocusNode = FocusNode();
    final _formKey = GlobalKey<FormState>();
    bool _isPaying = false;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Phone Number to Pay'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: MobileTextfield(
                        hitText: 'Phone Number',
                        labelText: 'Phone Number',
                        focusNode: _mobileFocusNode,
                        textEditingController: _mobileTextEditingController,
                        maxLines: 1,
                        message: 'Phone number required',
                        onCodeChange: (country) {
                          print(country);
                          _orderProvider.setSelectedCountry = country;
                        },
                        selectedCountry: _orderProvider.selectedCountry,
                        keyboardType: TextInputType.number),
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
                          color: Theme.of(context).primaryColor,
                          child: _isPaying
                              ? CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text('Pay'.toUpperCase()),
                          onPressed: () {
                            setState(() {
                              _isPaying = true;
                            });
                            if (_formKey.currentState.validate()) {
                              final _phone =
                                  _orderProvider.selectedCountry.dialingCode +
                                      _mobileTextEditingController.text
                                          .replaceAll('(', '')
                                          .replaceAll(')', '')
                                          .replaceAll('-', '')
                                          .replaceAll(' ', '');
                              _orderProvider
                                  .sendUssdPush(
                                      orderId: _orderProvider
                                          .getSelectedOrder.id
                                          .toString(),
                                      phone: _phone)
                                  .then((response) {
                                setState(() {
                                  _isPaying = false;
                                });
                                if (!response['success']) {
                                  showInSnackBar(value: response['message'] + '. Pay using given instructions or change payment number', context: context,color: Colors.red);
                                } else {
                                  showInSnackBar(value: response['message'] + '. Enter Pin to Verify the Payment', context: context);
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
            );
          }),
        );
      },
    );
  }

  void showInSnackBar({@required String value,@required BuildContext context,Color color}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color == null ? Colors.green : color,
      duration: Duration(seconds: 3),
    ));
  }

}
