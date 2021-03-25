import 'package:flutter/material.dart';

class NormalTextField extends StatelessWidget {
  final String title;
  final String subtitle;
  final double padding;

  const NormalTextField(
      {Key key,
      @required this.title,
      @required this.subtitle,
      this.padding = 10})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(padding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              subtitle,
              style: TextStyle(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
