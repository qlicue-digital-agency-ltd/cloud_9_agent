import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: new Container(
          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.2)),
        ),
      ),
    );
  }
}
