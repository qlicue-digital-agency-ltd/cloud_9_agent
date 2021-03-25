import 'package:cloud_9_agent/components/text-fields/rowed_text_field.dart';
import 'package:cloud_9_agent/models/order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef OrderCardOnTap = Function();
typedef OrderMoreOnTap = Function();

class OrderCard extends StatelessWidget {
  final OrderCardOnTap orderListCardOnTap;
  final OrderMoreOnTap orderMoreOnTap;
  final Order order;

  const OrderCard(
      {Key key,
      @required this.orderListCardOnTap,
      @required this.orderMoreOnTap,
      @required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: orderListCardOnTap,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 70,
                        child: Image.network(
                          order.client.avatar,
                          errorBuilder: (context, object, stackTrace) =>
                              Icon(Icons.person, size: 140),
                        ),),
                    title: Text(order.client.fullName,style: TextStyle(fontSize: 14.5),),
                    subtitle: Text(order.client.uuid),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.clipboard,
                    color: order.paymentStatus == "null"
                        ? Colors.red
                        : Colors.blue,
                  ),
                  onTap: orderListCardOnTap,
                  title: order.product != null
                      ? Text(
                          order.product.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          order.service.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No of Items:\t' + order.noOfItems),
                      Text(
                        order.paymentStatus == "null"
                            ? "Not Paid"
                            : order.paymentStatus,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.more_vert), onPressed: orderMoreOnTap),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text('Payment Status'),
                      Spacer(),
                      Text(
                        order.paymentStatus == 'null'
                            ? 'Unpaid'
                            : order.paymentStatus,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: order.paymentStatus == 'null'
                                ? Colors.red
                                : Colors.green),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: RowedTextField(
                    title: 'Order For',
                    subtitle: order.orderFor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: RowedTextField(
                    title: 'Amount',
                    subtitle: order.amount.toString(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
