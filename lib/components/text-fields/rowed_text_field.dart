import 'package:flutter/material.dart';

class RowedTextField extends StatelessWidget {
  final String title;
  final String subtitle;
  final int flex1;
  final int flex2;
  final bool toUpper;

  const RowedTextField(
      {Key key,
      @required this.title,
      @required this.subtitle,
      this.flex1 = 1,
      this.flex2 = 2,
      this.toUpper = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: flex1,
          child: Text(
            toUpper ? title.toUpperCase() : title,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        Expanded(
          flex: flex2,
          child: Text(
            subtitle,
            textAlign: TextAlign.end,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
