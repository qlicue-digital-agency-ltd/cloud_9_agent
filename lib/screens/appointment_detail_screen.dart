import 'package:cloud_9_agent/components/text-fields/label_text_field.dart';
import 'package:cloud_9_agent/models/appointment.dart';
import 'package:cloud_9_agent/provider/appointment_provider.dart';
import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:cloud_9_agent/provider/order_provider.dart';
import 'package:cloud_9_agent/provider/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cloud_9_agent/components/text-fields/rowed_text_field.dart';

import 'order_detail_screen.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final Appointment appointment;

  AppointmentDetailScreen({Key key, @required this.appointment})
      : super(key: key);

  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  bool _isPaying = false;

  TextEditingController _consultationReasonTextEditingController =
      TextEditingController();
  FocusNode _consultationReasonFocusNode = FocusNode();

  TextEditingController _amountTextController = TextEditingController();
  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();

  @override
  void initState() {
    _dateTextController.text = DateTime.now().toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text(
          'Appointment',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
        )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RowedTextField(
                          title: 'Type',
                          subtitle: widget.appointment.appointmentableType
                              .split('\\')[1]),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(children: [
                    //     Text('Type'),
                    //     Spacer(),
                    //
                    //     Text(widget.appointment.appointmentableType.split('\\')[1]) ,
                    //     Spacer()
                    //   ],),
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                          title: Text('Appointment'),
                          subtitle: Text(widget
                              .appointment.appointmentable.service.title)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RowedTextField(
                        title: 'Agent',
                        subtitle: "${widget.appointment.agentUuid}",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RowedTextField(
                        title: 'Date',
                        subtitle: widget.appointment.date,
                      ),
                    ),
                    // Text('Date: ${widget.appointment.date}') ,
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RowedTextField(
                        title: 'Phone',
                        subtitle: widget.appointment.phone,
                      ),
                    ),
                    // MobileTextfield(
                    //   focusNode: _phoneFocusNode,
                    //   hitText: '715 123 456',
                    //   keyboardType: TextInputType.phone,
                    //   labelText: 'Phone Number',
                    //   maxLines: 1,
                    //   message: 'Phone number required',
                    //   onCodeChange: (country) {
                    //     print(country);
                    //     _utilityProvider.setSelectedCountry = country;
                    //   },
                    //   selectedCountry: _utilityProvider.selectedCountry,
                    //   textEditingController: _phoneTextController,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    LabelTextfield(
                      focusNode: _amountFocusNode,
                      hitText: "",
                      keyboardType: TextInputType.number,
                      labelText: "Amount",
                      maxLines: 1,
                      message: 'Appointment Charges',
                      textEditingController: _amountTextController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {

                              if(_amountTextController.text.isEmpty){
                                showInSnackBar('Please ente the amount to pay',color: Colors.red);
                                return;
                              }

                              if ( double.parse(_amountTextController.text) >
                                  1000) {
                                _orderProvider
                                    .createOrder(
                                        userId:
                                            _authProvider.authenticatedUser.id,
                                        paymentPhone: widget.appointment.phone,
                                        agentCode: widget.appointment.agentUuid,
                                        orderableId: widget
                                            .appointment.appointmentable.id,
                                        orderableType: widget
                                            .appointment.appointmentableType
                                            .split('\\')[1],
                                        amount: double.parse(
                                            _amountTextController.text),
                                        noOfItems: 1)
                                    .then((value) {
                                  if (value) {
                                    print('errors');
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailScreen()));
                                  }
                                });
                              } else {
                                showInSnackBar('Amount too Low',color: Colors.red);
                              }
                            },
                            child: _isPaying ? CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ) : Text(
                              '\t\t\t\ Pay Now\t\t\t\t',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ]),
                    SizedBox(height: 20),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  void showInSnackBar(String value,{Color color}) {
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
      backgroundColor: color ?? Colors.green,
      duration: Duration(seconds: 3),
    ));
  }
}
