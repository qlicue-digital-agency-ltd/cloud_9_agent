import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/models/order.dart';
import 'package:cloud_9_agent/models/user.dart';
import 'package:cloud_9_agent/models/mno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
// import 'package:http/http.dart' as http;
import 'package:cloud_9_agent/httpHandler.dart';
import 'dart:convert';

import 'package:cloud_9_agent/provider/auth_provider.dart';

class OrderProvider with ChangeNotifier {
  AuthProvider _authProvider;
  update(AuthProvider authProvider) {
    _authProvider = authProvider;
    authenticatedUser = authProvider.authenticatedUser;

  }

  bool isLoading = false;

  User authenticatedUser;
  Country _selectedCountry = Country.TZ;

  bool _isSubmitingPaymentData = false;

  Country get selectedCountry => _selectedCountry;

  bool get isSubmitingPaymentData => _isSubmitingPaymentData;

  set setSelectedCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  bool _isFetchingOrderData = false;

  List<Order> _availableOrders = [];

  bool get isFetchingOrderData => _isFetchingOrderData;

  List<Order> get availableOrders => _availableOrders;
  Order _selectedOrder;

  //setter
  set selectOrder(Order order) {
    _selectedOrder = order;
    notifyListeners();
  }

  /// getter
  Order get getSelectedOrder => _selectedOrder;

  List<MNO> get mnoList => _mnoList;

  MNO get selectedMNO => _selectedMNO;

  MNO _selectedMNO = automnoList[0];

  set setSelectedMNO(MNO mno) {
    _selectedMNO = mno;
    notifyListeners();
  }

  List<MNO> _mnoList;

  getMNOList() {
    _mnoList = automnoList;
    notifyListeners();
  }

//fetch orders
  Future<bool> fetchOrders({@required int clientId}) async {
    bool hasError = true;
    _isFetchingOrderData = true;
    notifyListeners();

    final List<Order> _fetchedOrders = [];
    try {
      // final http.Response response =
      //     await http.get(api + "orders/" + clientId.toString());

      final HttpData httpResponse =
          await HttpHandler.httpGet(url: api + "orders/" + clientId.toString());

      final Map<String, dynamic> data = httpResponse.responseBody; //json.decode(response.body);

      if (httpResponse.statusCode == 200) {
        print(data.toString());
        data['orders'].forEach((orderData) {
          final order = Order.fromMap(orderData);
          _fetchedOrders.add(order);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableOrders = _fetchedOrders;
    _isFetchingOrderData = false;

    print(_availableOrders.length);
    notifyListeners();

    return hasError;
  }

  //Sign in User function..
  Future<bool> createOrder(
      {@required int userId,
      @required String paymentPhone,
      @required String agentCode,
      @required int orderableId,
      @required String orderableType,
      @required int noOfItems,
      @required double amount}) async {
    _isSubmitingPaymentData = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'user_id': userId,
      'payment_phone': paymentPhone,
      'product_id': orderableId,
      'amount': amount,
      'no_of_items': noOfItems,
      'agent_uuid': agentCode,
      'orderable_type': orderableType,
      'orderable_id': orderableId
    };

    if(!_authProvider.isAgent){
      return true;
    }

    // final http.Response response = await http.post(
    //   "${api}selcom/order/create",
    //   body: json.encode(authData),
    //   headers: {'Content-Type': 'application/json'},
    // );
    final HttpData httpResponse = await HttpHandler.httpPost(
      url: "${api}selcom/order/create",
      postBody: authData,
    );

    final Map<String, dynamic> responseData = httpResponse.responseBody; //json.decode(response.body);
    bool hasError = true;

    if (responseData.containsKey('order')) {
      //add to order list
      hasError = false;
      final _order = Order.fromMap(responseData['order']);
      _availableOrders.add(_order);
      selectOrder = _order;
    } else {
      hasError = true;
    }
    _isSubmitingPaymentData = false;
    notifyListeners();
    return hasError;
  }

  //Register in User function..
  Future<Map<String, dynamic>> sendUssdPush(
      {@required String orderId, @required String phone}) async {
    if(!_authProvider.isAgent){
      return {'status': false,'message': 'You are Not authorized to be an Agent',};
    }
    final Map<String, dynamic> _data = {'order_id': orderId, 'phone': phone};

    // final http.Response response = await http.post(
    //   "${api}selcom/order/pay",
    //   body: json.encode(_data),
    //   headers: {'Content-Type': 'application/json'},
    // );
    final HttpData httpResponse = await HttpHandler.httpPost(
      url: "${api}selcom/order/pay",
      postBody: _data,
    );

    final Map<String, dynamic> responseData = httpResponse.responseBody; //json.decode(response.body);
    bool hasError = true;

    notifyListeners();
    if (!responseData.containsKey('status')) {
      if (!responseData['status'])
        return {
          'status': false,
          'message': 'Error Occurred, Please Pay using given Procedures',
          'success': false
        };
    }
    if (responseData['transaction']['result_code'] == '000')

    return {
      'status': responseData['status'],
      'message': responseData['transaction']['message'],
      'success':
          responseData['transaction']['result_code'] == '000' ? true : false
    };
  }

  Future<Map<String,dynamic>> fetchAgentOrders() async {
    if(!_authProvider.isAgent){
      return {'status': false,'message': 'You are Not authorized to be an Agent',};
    }
    isLoading = true;
    notifyListeners();
    HttpData httpData = await HttpHandler.httpGet(
        url: '${api}agent/orders/${authenticatedUser.code}');

    if(!httpData.hasError){
      Map<String, dynamic> ordersMap = httpData.responseBody;
      _availableOrders.clear();
      ordersMap['orders'].forEach((order) {
        _availableOrders.add(Order.fromMap(order));
      });
    }

    isLoading = false;
    notifyListeners();
    return{'status' : !httpData.hasError,'message':httpData.message};
  }
}
