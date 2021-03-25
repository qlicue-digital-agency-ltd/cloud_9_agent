import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef CustomDropdownButtonOnChange = Function(String val);

class CustomDropdownButton extends StatelessWidget {
  final String value;
  final String title;
  final List<DropdownMenuItem> item;
  final CustomDropdownButtonOnChange customDropdownButtonOnChange;

  const CustomDropdownButton(
      {Key key,
      @required this.value,
      @required this.item,
      @required this.title,
      @required this.customDropdownButtonOnChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black45)),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Icon(
            FontAwesomeIcons.male,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Spacer(),
          DropdownButton(
              iconEnabledColor: Colors.white,
              style: TextStyle(color: Colors.black),
              underline: Container(),
              value: value,
              items: item,
              onChanged: (value) => customDropdownButtonOnChange(value)),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
