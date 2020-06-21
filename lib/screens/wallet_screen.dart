import 'package:cloud_9_agent/components/cards/matrix_card.dart';
import 'package:cloud_9_agent/components/cards/wallet_card.dart';
import 'package:cloud_9_agent/screens/booking_screen.dart';
import 'package:flutter/material.dart';

import 'background.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  title: Text('Wallet'),
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                WalletCard()
              ]),
        ),
      ),
    ));
  }
}
