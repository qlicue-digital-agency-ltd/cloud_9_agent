import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.cubicTo(size.width / 4, 3 * size.height / 4, 3 * size.width / 4,
        size.height / 4, size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
