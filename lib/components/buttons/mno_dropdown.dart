import 'package:cloud_9_agent/models/mno.dart';
import 'package:flutter/material.dart';

typedef MNODropdownButtonOnChange = Function(MNO);

class MNODropdown extends StatelessWidget {
  final MNODropdownButtonOnChange onChange;
  final String title;
  final MNO value;
  final List<MNO> items;
  final bool isRequired;

  const MNODropdown(
      {Key key,
      @required this.value,
      @required this.items,
      @required this.onChange,
      @required this.title,
      this.isRequired = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Container(
        padding: EdgeInsets.only(left: 5),
        height: 60,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: title),
                  TextSpan(
                      text: isRequired ? ' *' : '',
                      style: TextStyle(fontSize: 18, color: Colors.red))
                ], style: TextStyle(fontSize: 18, color: Colors.black45)),
              ),
            ),
            Expanded(
              flex: 3,
              child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                hint: Text(
                  '--- Select ' + title + '---',
                  overflow: TextOverflow.ellipsis,
                ),
                iconSize: 35,
                value: value,
                iconDisabledColor: Colors.grey,
                iconEnabledColor: Theme.of(context).primaryColor,
                items: items.map((val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(val.name),
                  );
                }).toList(),
                onChanged: (newValue) => onChange(newValue),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
