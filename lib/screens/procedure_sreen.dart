import 'package:cloud_9_agent/components/cards/service_card.dart';
import 'package:cloud_9_agent/components/tiles/no_item_tile.dart';
import 'package:cloud_9_agent/provider/service_provider.dart';

import 'package:cloud_9_agent/screens/service_detail_screen.dart';
import 'package:cloud_9_agent/screens/set_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProcedureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _serviceProvider = Provider.of<ServiceProvider>(context);
    Future<void> _getData() async {
      _serviceProvider.fetchServices();
    }

    void showSnackBar(value) {
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Procedures',
        style: TextStyle(color: Colors.white),
      )),
      body: _serviceProvider.isFetchingServiceData
          ? Center(child: CircularProgressIndicator())
          : _serviceProvider.availableServices.isEmpty
              ? RefreshIndicator(
                  onRefresh: _getData,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      Center(
                        child: NoItemTile(
                            icon: 'assets/icons/procedure.png',
                            title: 'No Procedures',
                            subtitle:
                                'Please there are no procedures available'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _serviceProvider.availableServices.length,
                        itemBuilder: (context, index) {
                          return ServiceCard(
                            onTapCalender: () {
                              // if (_serviceProvider.availableServices[index]
                              //     .procedures.isNotEmpty) {
                              // } else {
                              //   showSnackBar(
                              //       'There are no procedures scheduled for this event');
                              // }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SetAppointmentScreen(
                                      service: _serviceProvider
                                          .availableServices[index],
                                    ),
                                  ));

                              print(_serviceProvider
                                  .availableServices[index].procedures);
                            },
                            service: _serviceProvider.availableServices[index],
                            onTapMore: () {
                              print('moreeeee');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServiceDetailScreen(
                                      service: _serviceProvider
                                          .availableServices[index],
                                    ),
                                  ));
                            },
                          );
                        }),
                  ),
                  onRefresh: _getData),
    );
  }
}
