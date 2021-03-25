import 'package:cloud_9_agent/components/text-fields/date_text_field.dart';
import 'package:cloud_9_agent/models/service.dart';
import 'package:cloud_9_agent/models/customer.dart';
import 'package:cloud_9_agent/provider/appointment_provider.dart';
import 'package:cloud_9_agent/provider/client_provider.dart';
import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:cloud_9_agent/provider/service_provider.dart';
import 'package:cloud_9_agent/provider/utility_provider.dart';
import 'package:cloud_9_agent/screens/appointment_detail_screen.dart';
import 'package:cloud_9_agent/screens/appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetAppointmentScreen extends StatefulWidget {
  final Service service;
  final bool isProcedure;

  SetAppointmentScreen(
      {Key key, @required this.service, this.isProcedure = true})
      : super(key: key);

  @override
  _SetAppointmentScreenState createState() => _SetAppointmentScreenState();
}

class _SetAppointmentScreenState extends State<SetAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  TextEditingController _consultationReasonTextEditingController = TextEditingController();
  FocusNode _consultationReasonFocusNode = FocusNode();

  TextEditingController _dateTextController = TextEditingController();


  String _appointmentType;
  Service _selectedService;
  Client _selectedClient;

  List<String> appointmentTypes = ['Consultation', 'Procedure'];

  @override
  void initState() {
    _dateTextController.text = DateTime.now().toString();
    _appointmentType =
    widget.isProcedure ? appointmentTypes[1] : appointmentTypes[0];
    _selectedService = widget.service;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _clientProvider = Provider.of<ClientProvider>(context);
    // final _authProvider = Provider.of<AuthProvider>(context);
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _serviceProvider = Provider.of<ServiceProvider>(context);


    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
            title: Text(
              'Set Appointments',
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Text('Type'),
                        Spacer(),
                        DropdownButton(
                          value: _appointmentType,
                          onChanged: (String newValue) {
                            setState(() {
                              _appointmentType = newValue;
                            });
                          },
                          items: appointmentTypes.map<DropdownMenuItem<String>>
                            ((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Spacer()
                      ],),
                    ),
                    // _appointmentType == appointmentTypes[1] ?

                    // _serviceProvider.availableServices.length != 0 ?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Service'),
                        subtitle: DropdownButton(
                          isExpanded: true,
                          value: _selectedService,
                          onChanged: (Service newValue) {
                            setState(() {
                              _selectedService = newValue;
                            });
                          },
                          items: _serviceProvider.availableServices.map<
                              DropdownMenuItem<Service>>
                            ((Service value) {
                            return DropdownMenuItem<Service>(
                              value: value,
                              child: Text(
                                value.title, overflow: TextOverflow.fade,),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                        // : Container() : LabelTextfield(hitText: '',
                        // labelText: 'Reason',
                        // focusNode: _consultationReasonFocusNode,
                        // textEditingController: _consultationReasonTextEditingController,
                        // maxLines: null,
                        // message: null,
                        // keyboardType: null),

                    // Row(
                    //   children: <Widget>[
                    //     SizedBox(width: 10),
                    //     Image.asset('assets/icons/procedure.png', height: 50),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         'Appointment for ' + widget.service.title +
                    //             ' Procedure',
                    //         style: TextStyle(
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.bold,
                    //             fontStyle: FontStyle.italic),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter Details ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldDatePicker(
                      labelText: "Date",
                      prefixIcon: Icon(Icons.date_range),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      lastDate: DateTime.now().add(Duration(days: 366)),
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now().add(Duration(days: 1)),
                      onDateChanged: (selectedDate) {
                        print(selectedDate);
                        // Do something with the selected date
                        _dateTextController.text = selectedDate.toString();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton(
                      hint: Text('Select Client'),
                      value: _selectedClient,
                      items: _clientProvider.clients.map((
                          client) =>
                          DropdownMenuItem<Client>(
                            value: client,
                            child: Text(client.fullName),
                          )
                      ).toList(),
                      onChanged: (Client selected){
                        setState(() {
                          _selectedClient = selected;
                        });

                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {

                              if(_selectedClient == null){
                                showInSnackBar('Please select Client',color: Colors.red);
                                return;
                              }

                              if (_formKey.currentState.validate()) {
                                if (_appointmentType == appointmentTypes[1]) {
                                  _appointmentProvider
                                      .postProcedureAppointment(
                                    userId: _selectedClient.id,
                                    serviceId: _selectedService.id,
                                    date: _dateTextController.text,
                                    phoneNumber: _selectedClient.phone,
                                  )
                                      .then((result) {
                                    if (!result['success']) {

                                    } else {
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>AppointmentDetailScreen(appointment: result['appointment'])));
                                      // Navigator.pop(context);
                                    }
                                  });
                                }
                                if (_appointmentType == appointmentTypes[0]) {
                                  _appointmentProvider
                                      .postConsultationAppointment(
                                      date: _dateTextController.text,
                                      userId: _selectedClient.id,
                                      phoneNumber: _selectedClient.phone,
                                      consultationId: _selectedService.id).then((value)  {
                                    if(!value){
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => AppointmentScreen()));
                                    }
                                  });
                                }
                              }

                            },
                            child: Text(
                              '\t\t\t\Book Now\t\t\t\t',
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
