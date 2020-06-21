import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Total Amount',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'TZS 2,000,000 /-',
          style: TextStyle(color: Colors.white, fontSize: 20),
        )
      ]),
    );
  }
}
