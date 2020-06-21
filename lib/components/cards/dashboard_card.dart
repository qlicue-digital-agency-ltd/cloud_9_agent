import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            height: 150,
            child: Row(children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Stay home!',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Schedule an e-vist and discuss the plan with a doctor',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.notifications,
                color: Colors.white,
                size: 100,
              )
            ]),
          ),
          Positioned(
            right: 0,
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.close),
                color: Colors.blue,
                onPressed: () {
                  print('object');
                },
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
