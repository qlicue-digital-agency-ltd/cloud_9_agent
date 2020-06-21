import 'package:cloud_9_agent/components/cards/matrix_card.dart';
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MatrixCard(
                          backgroundColor: Colors.orange[50],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingScreen(),
                                ));
                          },
                          subtitle: '30',
                          title: 'Bookings',
                          textColor: Colors.deepOrange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MatrixCard(
                          backgroundColor: Colors.green[50],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ));
                          },
                          subtitle: '1,200,000 /-',
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
    ));
  }
}
