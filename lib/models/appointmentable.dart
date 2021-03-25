import 'package:cloud_9_agent/models/service.dart';
import 'package:cloud_9_agent/models/order.dart';
import 'package:flutter/material.dart';

class Appointmentable {
  final int id;
  final String startTime;
  final String endTime;
  final String day;
  final String date;
  final int serviceId;
  final String practionerUuid;
  Service service;
  List<Order> orders;

  Appointmentable(
      {@required this.id,
      @required this.date,
      @required this.startTime,
      @required this.endTime,
      @required this.day,
      @required this.serviceId,
      @required this.practionerUuid,
      @required this.orders});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'day': day,
      'service_id': serviceId,
      'practioner_uuid': practionerUuid,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Appointmentable.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['practioner_uuid'] != null),
        id = map['id'],
        date = map['date'],
        startTime = map['start_time'],
        endTime = map['end_time'],
        day = map['day'],
        serviceId = int.parse(map['service_id'].toString()),
        practionerUuid = '',//map['practioner_uuid'],
        service = Service.fromMap(map['service']),
        orders =(map['orders'] as List).map((i) => Order.fromMap(i)).toList();
  // order.add(Order.fromMap(map['o'])
}
