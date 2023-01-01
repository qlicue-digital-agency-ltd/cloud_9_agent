import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/models/appointment.dart';
import 'package:cloud_9_agent/models/user.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_9_agent/httpHandler.dart';
import '../provider/auth_provider.dart';

import 'dart:developer';

class AppointmentProvider with ChangeNotifier {
AuthProvider _authProvider;
  void update(AuthProvider _authProvider){
    this._authProvider = _authProvider;
    authenticatedUser = _authProvider.authenticatedUser;
  }

  //variable declaration
  User authenticatedUser;
  bool _isFetchingAppointmentData = false;
  bool _isCreatingAppointmentData = false;
  List<Appointment> _availableAppointments = [];
  bool isLoading = false;






//getters
  bool get isFetchingAppointmentData => _isFetchingAppointmentData;

  bool get isCreatingAppointmentData => _isCreatingAppointmentData;
  List<Appointment> get availableAppointments => _availableAppointments;

  Future<bool> fetchAppointments({@required int clientId}) async {
    if(!_authProvider.isAgent){
      return true;
    }
    bool hasError = true;
    _isFetchingAppointmentData = true;
    notifyListeners();

    final List<Appointment> _fetchedAppointments = [];
    try {
      // final http.Response response =
      //     await http.get(api + "appointment/client/" + clientId.toString());
      final HttpData httpResponse = await HttpHandler.httpGet(url: api + "appointment/client/" + clientId.toString());

      final Map<String, dynamic> data = httpResponse.responseBody; //json.decode(response.body);

      if (httpResponse.statusCode == 200) {
        data['appointments'].forEach((appointmentData) {
          final appointment = Appointment.fromMap(appointmentData);
          _fetchedAppointments.add(appointment);
        });

        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableAppointments = _fetchedAppointments;
    _isFetchingAppointmentData = false;
    print(_availableAppointments.length);
    notifyListeners();

    return hasError;
  }

  Future<Map<String,dynamic>> postProcedureAppointment({
    @required int userId,
    @required String date,
    @required int serviceId,
    @required String phoneNumber,
  }) async {
    if(!_authProvider.isAgent){
      return {'success': false,'message': 'You are Not authorized to be an Agent',};
    }
    bool hasError = true;
    Appointment _appointment ;
    _isCreatingAppointmentData = true;
    notifyListeners();

    final Map<String, dynamic> appointmentData = {
      'date': date,
      'user_id': userId,
      'agent_uuid': authenticatedUser.code,
      'status': 'booked',
      'orderable_type': 'App\\Procedure',
      'orderable_id': serviceId,
      'no_of_items': 1,
      'payment_phone': phoneNumber
    };

    print("+++++++++++++++++++++++");
    print(appointmentData);
    print("+++++++++++++++++++++++");
    try {
      // final http.Response response = await http.post(
      //   api + "procedure/appointment/" + serviceId.toString(),
      //   body: json.encode(appointmentData),
      //   headers: {'Content-Type': 'application/json'},
      // );
      final HttpData httpResponse = await HttpHandler.httpPost(
        url: api + "procedure/appointment/" + serviceId.toString(),
        postBody: appointmentData,
      );

      final Map<String, dynamic> data = httpResponse.responseBody; //json.decode(response.body);
      // print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
      // print(data);
      if (httpResponse.statusCode == 201) {
        // print(data);
         _appointment = Appointment.fromMap(data['appointment']);
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }
    _isCreatingAppointmentData = false;

    notifyListeners();
    fetchAppointments(clientId: userId);

    return {'success':! hasError, 'appointment':_appointment};
  }

  ///consultation.........
  Future<bool> postConsultationAppointment({
    @required String date,
    @required int userId,
    @required String phoneNumber,
    @required int consultationId,
  }) async {
    if(!_authProvider.isAgent){
      return false;
    }
    bool hasError = true;
    _isCreatingAppointmentData = true;
    notifyListeners();

    final Map<String, dynamic> appointmentData = {
      'date': date,
      'user_id': userId,
      'agent_uuid': authenticatedUser.code,
      'status': 'booked',
      'orderable_type': 'App\\Consultation',
      'orderable_id': consultationId,
      'no_of_items': 1,
      'payment_phone': phoneNumber
    };

    print("+++++++++++++++++++++++");
    print(appointmentData);
    try {
      // final http.Response response = await http.post(
      //   api + "consultation/appointment/" + consultationId.toString(),
      //   body: json.encode(appointmentData),
      //   headers: {'Content-Type': 'application/json'},
      // );
      final HttpData httpResponse = await HttpHandler.httpPost(
        url: api + "consultation/appointment/" + consultationId.toString(),
        postBody: appointmentData,
      );

      final Map<String, dynamic> data = httpResponse.responseBody; //json.decode(response.body);



      if (httpResponse.statusCode == 201) {
        print(data);
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }
    _isCreatingAppointmentData = false;

    notifyListeners();
    fetchAppointments(clientId: userId);

    return hasError;
  }

  Future<void> fetchAgentAppointments() async {
    if(!_authProvider.isAgent){
      return false;
    }
    isLoading = true;
    notifyListeners();
    HttpData httpData = await HttpHandler.httpGet(url: '${api}appointments/${authenticatedUser.code}');

    try {
      _availableAppointments.clear();
      httpData.responseBody['bookings'].forEach((appointment) {
        _availableAppointments.add(
            Appointment.fromMap(appointment)
        );
      });
      isLoading = false;
      notifyListeners();
    }catch(e){
      isLoading = false;
      notifyListeners();
    }

  }
}
