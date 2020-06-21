import 'package:cloud_9_client/models/transaction.dart';
import 'package:flutter/material.dart';

typedef TransactionListCardOnTap = Function();

class TransactionListCard extends StatelessWidget {
  final TransactionListCardOnTap onDeleteTap;
  final TransactionListCardOnTap onViewTap;
  final Transaction transaction;

  const TransactionListCard(
      {Key key,
      @required this.onDeleteTap,
      @required this.onViewTap,
      @required this.transaction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        clipBehavior: Clip.antiAlias,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Icon(
                Icons.receipt,
                color: Colors.blue,
                size: 50,
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
                    transaction.uuid,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(transaction.title),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onViewTap,
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
                    Icons.note,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 3),
                  Text('View'),
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
        ]));
  }
}
