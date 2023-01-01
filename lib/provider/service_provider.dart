import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/httpHandler.dart';
import 'package:cloud_9_agent/models/service.dart';
import 'package:flutter/material.dart';


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
      // final http.Response response = await http.get(api + "services");
      final HttpData httpResponse = await HttpHandler.httpGet(url: api + "services");

      final Map<String, dynamic> data = httpResponse.responseBody;  //json.decode(response.body);


      if (httpResponse.statusCode == 200) {
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
