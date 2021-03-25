import 'package:cloud_9_agent/components/cards/order_card.dart';
import 'package:cloud_9_agent/components/tiles/no_item_tile.dart';
import 'package:cloud_9_agent/constants/constants.dart';
import 'package:cloud_9_agent/models/order.dart';
import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:cloud_9_agent/provider/order_provider.dart';
import 'package:cloud_9_agent/screens/order_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<OrderProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);

    Future<void> _getData() async {
      _orderProvider.fetchAgentOrders();
    }

    void _settingModalBottomSheet(context, Order order) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              child: new Wrap(
                children: <Widget>[
                   ListTile(
                      leading: new Icon(
                        Icons.assignment,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: new Text('View'),
                      onTap: () {
                        Navigator.pop(context);
                        _orderProvider.selectOrder = order;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailScreen()));
                      }),
                   ListTile(
                    leading: new Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    title: new Text('Delete'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: _orderProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : _orderProvider.availableOrders.isEmpty
              ? RefreshIndicator(
                  onRefresh: _getData,
                  child: ListView(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/3,),
                      Center(
                        child: NoItemTile(
                            icon: 'assets/icons/calendar.png',
                            title: 'No orders',
                            subtitle: 'Please there are no available orders'),
                      )
                    ],
                  ),
                )
              : RefreshIndicator(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _orderProvider.availableOrders.length,
                        itemBuilder: (context, index) {
                          return OrderCard(
                              order: _orderProvider.availableOrders[index],
                              orderListCardOnTap: () {
                                _orderProvider.selectOrder =
                                    _orderProvider.availableOrders[index];
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrderDetailScreen()));
                              },
                              orderMoreOnTap: () {
                                _settingModalBottomSheet(context,
                                    _orderProvider.availableOrders[index]);
                              });
                        }),
                  ),
                  onRefresh: _getData),
    );
  }
}
