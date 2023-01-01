import 'package:cloud_9_agent/components/cards/dashboard_card.dart';
import 'package:cloud_9_agent/components/cards/matrix_card.dart';

import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:cloud_9_agent/provider/client_provider.dart';
import 'package:cloud_9_agent/provider/utility_provider.dart';
import 'package:cloud_9_agent/provider/product_provider.dart';
import 'package:cloud_9_agent/provider/service_provider.dart';
import 'package:cloud_9_agent/provider/order_provider.dart';
import 'package:cloud_9_agent/provider/appointment_provider.dart';

import 'package:cloud_9_agent/screens/customer_screen.dart';
import 'package:cloud_9_agent/screens/appointment_screen.dart';
import 'package:cloud_9_agent/screens/product_screen.dart';
import 'package:cloud_9_agent/screens/wallet_screen.dart';
import 'package:cloud_9_agent/screens/service_screen.dart';
import 'package:cloud_9_agent/screens/order_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'background.dart';

class HomeScreen extends StatelessWidget {


  bool _isLoading = false;
  bool onLand = true;

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    final _clientProvider = Provider.of<ClientProvider>(context);
    final _productProvider = Provider.of<ProductProvider>(context);
    final _serviceProvider = Provider.of<ServiceProvider>(context);
    final _orderProvider = Provider.of<OrderProvider>(context);
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);

    //   _utilityProvider.getAgentInfo();


    return FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');

            if (!projectSnap.data['agentData']['success']) {
              showInSnackBar(projectSnap.data['agentData']['message'],
                  context: context);
            }
            if (!projectSnap.data['agentClients']['success']) {
              showInSnackBar(projectSnap.data['agentClients']['message'],
                  context: context);
            }

            if (projectSnap.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();

            return Container();
          }

          return Background(
            screen: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        _authProvider.authenticatedUser.avatar),
                                    onError: (object, stackTrace) => Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 20))),
                          ),
                        ),
                        SizedBox(height: 50),
                        Text(
                          'Hello,',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w100),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _authProvider.authenticatedUser?.name == null
                                    ? ""
                                    : _authProvider.authenticatedUser.name,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Icon(FontAwesomeIcons.male,
                                size: 30, color: Colors.white)
                          ],
                        ),
                        _authProvider.isAgent
                            ? Container()
                            : DashboardCard(
                                title: 'Not an Agent',
                                description:
                                    "This app is for Cloud9 Agents, you don't have Agent Privilege",
                                iconColor: Colors.red,
                              ),
                        SizedBox(height: 20),
                        _authProvider.isAgent
                            ? Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MatrixCard(
                                            isLoading: _productProvider
                                                .isFetchingProductData,
                                            backgroundColor: Colors.blue[50],
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductScreen(),
                                                  ));
                                            },
                                            subtitle:
                                                '${_productProvider.availableProducts.length}',
                                            title: 'Products',
                                            textColor: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MatrixCard(
                                            isLoading: _serviceProvider
                                                .isFetchingServiceData,
                                            backgroundColor: Colors.red[50],
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ServiceScreen(),
                                                  ));
                                            },
                                            subtitle:
                                                '${_serviceProvider.availableServices.length}',
                                            title: 'Services',
                                            textColor: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MatrixCard(
                                            isLoading:
                                                _appointmentProvider.isLoading,
                                            backgroundColor: Colors.red[50],
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AppointmentScreen(),
                                                  ));
                                            },
                                            subtitle:
                                                '${_appointmentProvider.availableAppointments.length}',
                                            title: 'Appointments',
                                            textColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MatrixCard(
                                            isLoading:
                                                _clientProvider.isLoading,
                                            backgroundColor: Colors.blue[50],
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomerScreen(),
                                                  ));
                                            },
                                            subtitle:
                                                '${_clientProvider.clients.length}',
                                            title: 'Customers',
                                            textColor: Colors.blue,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MatrixCard(
                                            isLoading: _orderProvider.isLoading,
                                            backgroundColor: Colors.orange[50],
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderScreen(),
                                                  ));
                                            },
                                            subtitle:
                                                '${_orderProvider.availableOrders.length}',
                                            title: 'Orders',
                                            textColor: Colors.deepOrange,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MatrixCard(
                                            isLoading:
                                                _utilityProvider.isLoading,
                                            backgroundColor: Colors.green[50],
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WalletScreen(),
                                                  ));
                                            },
                                            subtitle:
                                                '${_utilityProvider?.myWallet?.amount}',
                                            title: 'Wallet',
                                            textColor: Colors.green,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : Center(
                                child: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        _authProvider
                                            .getUserRole()
                                            .then((response) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          showInSnackBar(response['message'],
                                              context: context,
                                              color: response['isAgent']
                                                  ? Colors.green
                                                  : Colors.red);
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: _isLoading
                                            ? CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              )
                                            : Text('Refresh '),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ]),
                ),
              ),
            ),
          );
        },
        future: _loadData(
            utilityProvider: _utilityProvider,
            clientProvider: _clientProvider,
            orderProvider: _orderProvider,
            appointmentProvider: _appointmentProvider,
            authProvider: _authProvider,
            productProvider: _productProvider,
            serviceProvider: _serviceProvider));
  }

  void showInSnackBar(String value,
      {@required BuildContext context, Color color}) {
    FocusScope.of(context).requestFocus(new FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // Scaffold.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
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

  Future<void> _loadData(
      {@required UtilityProvider utilityProvider,
      @required ClientProvider clientProvider,
      @required OrderProvider orderProvider,
      @required ProductProvider productProvider,
      @required ServiceProvider serviceProvider,
      @required AppointmentProvider appointmentProvider,
      @required AuthProvider authProvider}) async {
    if (onLand) {
      onLand = false;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // authProvider.getUserRole();
        clientProvider.getAgentClients();

        utilityProvider.getAgentInfo();
        productProvider.fetchProducts();
        serviceProvider.fetchServices();
        orderProvider.fetchAgentOrders();
        appointmentProvider.fetchAgentAppointments();
      });
    }
  }
}
