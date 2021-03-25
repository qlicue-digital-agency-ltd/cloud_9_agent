import 'dart:developer';

import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/httpHandler.dart';
import 'package:cloud_9_agent/models/booking.dart';
import 'package:cloud_9_agent/models/transaction.dart';
import 'package:cloud_9_agent/models/user.dart';
import 'package:cloud_9_agent/models/walet.dart';
import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:cloud_9_agent/models/order.dart';

class UtilityProvider extends ChangeNotifier {
  User _authenticatedUser;
  AuthProvider _authProvider;

  bool isLoading = false;

  update(AuthProvider authProvider) {
    _authProvider = authProvider;
    _authenticatedUser = authProvider.authenticatedUser;
  }



  String _chartDropdownValue = 'Customers';

//getter
  String get chartDropdownValue => _chartDropdownValue;

  //setter
  set selectChartDropdownValue(String value) {
    _chartDropdownValue = value;
    notifyListeners();
  }

  List<Transaction> transactions = [];
  List<Booking> bookings = [];
  List<Order> orders = [];
  Wallet myWallet = Wallet(id: 0, uuid: '-', amount: 0);

  Future<Map<String, dynamic>> getAgentInfo() async {
    if(!_authProvider.isAgent){
      return {'success': false,'message': 'You are Not authorized to be an Agent',};
    }
    isLoading =  true;
    notifyListeners();
    HttpData agentData = await HttpHandler.httpGet(
        url: '${api}agent/${_authenticatedUser.id}');

    if (!agentData.hasError) {
      Map<String, dynamic> agentMap = agentData.responseBody['agent'];
    myWallet = Wallet(
          id: agentMap['wallet']['id'],
          uuid: agentMap['wallet']['agent_uuid'],
          amount: double.parse('${agentMap['wallet']['amount']}'));

    }
    isLoading = false;
    notifyListeners();
    return {'success': !agentData.hasError,'message': agentData.message,};

  }

  final double _maxSlide = 225.0;
  bool _canBeDragged = true;
  AnimationController _animationController;
  Country _selectedCountry = Country.TZ;

  //getters
  double get maxSlide => _maxSlide;
  bool get canBeDragged => _canBeDragged;
  AnimationController get animationController => _animationController;
  Country get selectedCountry => _selectedCountry;
  //setters
  set setAnimationController(AnimationController _animationCtrlr) {
    _animationController = _animationCtrlr;
    notifyListeners();
  }

  //functions
  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  void onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft =
        _animationController.isDismissed && details.globalPosition.dx < 0;
    bool isDragCloseFromRight =
        _animationController.isCompleted && details.globalPosition.dx > 0;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / _maxSlide;
      _animationController.value += delta;
    }
  }

  void onDragEnd(
      DragEndDetails details,
      BuildContext context,
      ) {
    if (_animationController.isDismissed || _animationController.isCompleted)
      return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _close();
      Drawer();
    } else {
      _open();
    }
  }

  /// Starts an animation to open the drawer.
  ///
  /// Typically called by [ScaffoldState.openDrawer].
  void _open() {
    _animationController.fling(velocity: 1.0);
  }

  /// Starts an animation to close the drawer.
  void _close() {
    _animationController.fling(velocity: -1.0);
  }

  set setSelectedCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }
}
