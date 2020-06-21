import 'package:cloud_9_agent/animations/background/home_background_major_clipper.dart';
import 'package:flutter/material.dart';

import 'drawer_screen.dart';



class Background extends StatelessWidget {
  final Widget screen;


  const Background({Key key, @required this.screen})
      : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(children: <Widget>[
          Container(
            color: Color(0xfff4f4f4),
          ),
          ClipPath(
            clipper: HomeBackgroundMajorClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[700], Colors.blue[200]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
          ),
          screen
        ]),
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
