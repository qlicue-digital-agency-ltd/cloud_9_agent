import 'package:cloud_9_agent/components/cards/dashboard_card.dart';
import 'package:cloud_9_agent/components/cards/matrix_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'background.dart';

class HomeScreen extends StatelessWidget {
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
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/matty.jpg'))),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Hello,',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Matias,',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Icon(FontAwesomeIcons.male, size: 30, color: Colors.white)
                  ],
                ),
                DashboardCard(),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MatrixCard(
                          backgroundColor: Colors.blue[50],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ));
                          },
                          subtitle: '1,2000',
                          title: 'Customers',
                          textColor: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MatrixCard(
                          backgroundColor: Colors.red[50],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ));
                          },
                          subtitle: '300',
                          title: 'Transactions',
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
                          backgroundColor: Colors.orange[50],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
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
