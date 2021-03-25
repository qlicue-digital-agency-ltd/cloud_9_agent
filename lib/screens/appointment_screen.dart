import 'package:cloud_9_agent/components/cards/appointment_card.dart';
import 'package:cloud_9_agent/components/tiles/no_item_tile.dart';
import 'package:cloud_9_agent/provider/appointment_provider.dart';
import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:cloud_9_agent/provider/service_provider.dart';
import 'package:cloud_9_agent/provider/order_provider.dart';
import 'package:cloud_9_agent/screens/order_detail_screen.dart';
import 'package:cloud_9_agent/screens/set_appointment_screen.dart';
import 'package:cloud_9_agent/screens/appointment_detail_screen.dart';


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool _showFloatingButtonText = true;
  ScrollController _scrollController = ScrollController();

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

  scrollController(){
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
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _serviceProvider = Provider.of<ServiceProvider>(context);
    final _orderProvider = Provider.of<OrderProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ServiceListScreen()));
            },
          )
        ],
      ),
      body: _appointmentProvider.isFetchingAppointmentData
          ? Center(child: CircularProgressIndicator())
          : _appointmentProvider.availableAppointments.isEmpty
              ? RefreshIndicator(
                  onRefresh: _appointmentProvider.fetchAgentAppointments,
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        NoItemTile(
                            icon: 'assets/icons/calendar.png',
                            title: 'No Consultation',
                            subtitle:
                                'Please there are no available consultation'),
                        Spacer(),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  child: SizedBox.expand(
                    child: ListView.builder(
                      controller: _scrollController,
                        itemCount:
                            _appointmentProvider.availableAppointments.length,
                        itemBuilder: (context, index) {
                          return AppointmentCard(
                            appointmentListCardOnTap: () {
                              if(_appointmentProvider.availableAppointments[index].appointmentable.orders.length == 0 ){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailScreen(appointment: _appointmentProvider.availableAppointments[index],)));
                              }
                              else{
                               _orderProvider.selectOrder = _appointmentProvider.availableAppointments[index].appointmentable.orders[0];
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailScreen()));
                              }

                            },
                            appointmentMoreOnTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailScreen(appointment: _appointmentProvider.availableAppointments[index],)));
                            },
                            appointment:
                                _appointmentProvider.availableAppointments[index],
                          );
                        }),
                  ),
                  onRefresh: _appointmentProvider.fetchAgentAppointments),
      floatingActionButton: _showFloatingButtonText ?  FlatButton(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.blue)
      ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add,color: Colors.white,),
          _showFloatingButtonText ? Text('Set Appointment',style: TextStyle(fontSize: 14,color: Colors.white),) : Container(),
        ],
      ),
        color: Colors.blue,// Icon(Icons.add),
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SetAppointmentScreen(service: _serviceProvider.availableServices[0],isProcedure: false,)));
      },) : FloatingActionButton(
        mini: true,
        tooltip: 'Set Appointment',
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SetAppointmentScreen(service: _serviceProvider.availableServices[0],isProcedure: false,)));
      },child: Icon(Icons.add,color: Colors.white,),),
    );
  }
}
