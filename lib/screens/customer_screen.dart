import 'package:cloud_9_agent/components/text-fields/label_text_field.dart';
import 'package:cloud_9_agent/components/tiles/custome_list_tile.dart';
import 'package:cloud_9_agent/models/customer.dart';
import 'package:cloud_9_agent/provider/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:cloud_9_agent/models/user.dart';
import 'dart:developer';

import 'package:cloud_9_agent/components/search/search_users.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showFloatingButtonText = true;

  ScrollController _scrollController = ScrollController();

  bool _isBusy = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _clientCodeTextEditingController =
      TextEditingController();
  FocusNode _clientCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    scrollController();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  scrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _showFloatingButtonText = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showFloatingButtonText = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ClientProvider _clientProvider = Provider.of<ClientProvider>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Customers'),
          // actions: [
          //   IconButton(icon: Icon(Icons.search),onPressed: (){
          //      showSearch(context: context,delegate: SearchUsers(_clientProvider)).then((value) {
          //        log(value.toString(),name:'Search Result');
          //      });
          //   },)
          // ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: RefreshIndicator(
            onRefresh: () {
              return _clientProvider
                  .getAgentClients()
                  .then((value) => print(value.toString()));
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _clientProvider.clients.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomerListTile(
                    customer: _clientProvider.clients[index],
                    onDeleteTap: () {},
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButton: _showFloatingButtonText
            ? FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.blue)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    _showFloatingButtonText
                        ? Text(
                            'New Customer',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        : Container(),
                  ],
                ),
                color: Colors.blue, // Icon(Icons.add),
                onPressed: () {
                  _showNewCustomerDialog(
                      context: context, clientProvider: _clientProvider);
                },
              )
            : FloatingActionButton(
                mini: true,
                tooltip: 'Add Customer',
                onPressed: () {
                  _showNewCustomerDialog(
                      context: context, clientProvider: _clientProvider);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ));
  }

  Future<void> _showNewCustomerDialog(
      {@required BuildContext context,
      @required ClientProvider clientProvider}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          // title: Text('Appointment Booked'),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Card(
              child: Container(
                // color: Colors.white,
                padding: EdgeInsets.all(8),
                // decoration:
                //     new BoxDecoration(color: Theme.of(context).primaryColor),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppBar(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('New Customer'),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(height: 8),
                        LabelTextfield(
                          focusNode: _clientCodeFocusNode,
                          hitText: "CL00012",
                          keyboardType: TextInputType.text,
                          labelText: "Client Code",
                          maxLines: 1,
                          message: null,
                          textEditingController:
                              _clientCodeTextEditingController,
                          textInputAction: TextInputAction.send,
                          onEditingComplete: () {
                            _clientCodeFocusNode.unfocus();
                          },
                          validator: (input) {
                            if (input.isEmpty)
                              return "Please enter Client code";

                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: _isBusy
                              ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CircularProgressIndicator(
                                      backgroundColor: Colors.white),
                                )
                              : Text('Add'),
                          color: Colors.blue,
                          onPressed: () => addCustomer(
                              setState: setState,
                              clientProvider: clientProvider),
                          textColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  addCustomer(
      {@required StateSetter setState,
      @required ClientProvider clientProvider}) async {
    if (_formKey.currentState.validate()) {
      setState((){
        _isBusy = true;
      });

      Map<String, dynamic> response = await clientProvider.addClientByCode(
          clientCode: _clientCodeTextEditingController.text);
      setState(() {
        _isBusy = false;
      });
      if (response['hasError']) {
        showInSnackBar(response['message']);
      }else{
        Navigator.of(context).pop();
      }
    }
  }

  void showInSnackBar(String value, {Color color}) {
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
      backgroundColor: color ?? Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
}
