import 'package:flutter/material.dart';

class UtilityProvider extends ChangeNotifier {
  String _chartDropdownValue = 'Customers';

//getter
  String get chartDropdownValue => _chartDropdownValue;

  //setter
  set selectChartDropdownValue(String value) {
    _chartDropdownValue = value;
    notifyListeners();
  }
}
