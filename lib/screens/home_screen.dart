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
  ProductProvider _productProvider;
  ServiceProvider _serviceProvider;

  bool onLand = true;

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    final _clientProvider = Provider.of<ClientProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);
    _serviceProvider = Provider.of<ServiceProvider>(context);
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
                                  image: NetworkImage(
                                    _authProvider.authenticatedUser?.avatar ==
                                            null
                                        ? ''
                                        : _authProvider
                                            .authenticatedUser.avatar,
                                  ),
                                  onError: (object, stackTrace) {}),
                            ),
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
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MatrixCard(
                                  isLoading:
                                      _productProvider.isFetchingProductData,
                                  backgroundColor: Colors.blue[50],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductScreen(),
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
                                  isLoading:
                                      _serviceProvider.isFetchingServiceData,
                                  backgroundColor: Colors.red[50],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ServiceScreen(),
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
                                  isLoading: _appointmentProvider.isLoading,
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
                                  isLoading: _clientProvider.isLoading,
                                  backgroundColor: Colors.blue[50],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerScreen(),
                                        ));
                                  },
                                  subtitle: '${_clientProvider.clients.length}',
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
                                          builder: (context) => OrderScreen(),
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
                                  isLoading: _utilityProvider.isLoading,
                                  backgroundColor: Colors.green[50],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WalletScreen(),
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
        appointmentProvider: _appointmentProvider));
  }

  void showInSnackBar(String value, {@required BuildContext context}) {
    FocusScope.of(context).requestFocus(new FocusNode());

    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Future<void> _loadData(
      {@required UtilityProvider utilityProvider,
      @required ClientProvider clientProvider,
      @required OrderProvider orderProvider,
      @required AppointmentProvider appointmentProvider}) async {
    if (onLand) {
      onLand = false;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        clientProvider.getAgentClients();

        utilityProvider.getAgentInfo();
        _productProvider.fetchProducts();
        _serviceProvider.fetchServices();
        orderProvider.fetchAgentOrders();
        appointmentProvider.fetchAgentAppointments();

      });
    }
  }
}
