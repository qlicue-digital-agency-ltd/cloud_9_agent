import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/models/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceProvider with ChangeNotifier {

  //variable declaration
  bool _isFetchingServiceData = false;
  List<Service> _availableServices = [];

//getters
  bool get isFetchingServiceData => _isFetchingServiceData;
  List<Service> get availableServices => _availableServices;

  //setters
  set setSelectedServiceList(List<Service> serviceList) {
    _availableServices = serviceList;
    notifyListeners();
  }

  Future<bool> fetchServices() async {
    bool hasError = true;
    _isFetchingServiceData = true;
    notifyListeners();

    final List<Service> _fetchedServices = [];
    try {
      final http.Response response = await http.get(api + "services");

      final Map<String, dynamic> data = json.decode(response.body);


      if (response.statusCode == 200) {
        data['services'].forEach((serviceData) {
          final service = Service.fromMap(serviceData);
          _fetchedServices.add(service);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableServices = _fetchedServices;
    _isFetchingServiceData = false;
    notifyListeners();

    return hasError;
  }
}
