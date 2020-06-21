import 'package:cloud_9_agent/provider/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    return DropdownButton<String>(
      value: _utilityProvider.chartDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      onChanged: (String value) {
        _utilityProvider.selectChartDropdownValue = value;
      },
      items: <String>['Customers', 'Transactions', 'Bookings']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
