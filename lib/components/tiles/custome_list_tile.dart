import 'package:cloud_9_agent/models/customer.dart';
import 'package:flutter/material.dart';

typedef CustomerListTileOnTap = Function();

class CustomerListTile extends StatelessWidget {
  final CustomerListTileOnTap onDeleteTap;
  final CustomerListTileOnTap onTap;
  final Client customer;

  const CustomerListTile(
      {Key key,
      @required this.onDeleteTap,
      @required this.onTap,
      @required this.customer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      customer.avatar,
                      height: 80,
                      errorBuilder: (context,object,stackTrace) => Icon(Icons.person,size: 80),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          customer.uuid,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(customer.fullName),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: onDeleteTap,
                  child: Container(
                    width: 60,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(height: 3),
                        Text('Delete'),
                      ],
                    ),
                  ),
                )
              ])),
    );
  }
}
