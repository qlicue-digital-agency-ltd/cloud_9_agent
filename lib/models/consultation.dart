import 'package:cloud_9_agent/models/service.dart';
import 'package:flutter/material.dart';

class Consultation {
  final int id;
  final String startTime;
  final String endTime;
  final String date;
  final int serviceId;
  final String practionerUuid;
  Service service;

  Consultation(
      {@required this.id,
      @required this.date,
      @required this.startTime,
      @required this.endTime,
      @required this.serviceId,
      @required this.practionerUuid});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'service_id': serviceId,
      'practioner_uuid': practionerUuid,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Consultation.fromMap(Map<String, dynamic> map)
      : 
        id = map['id'],
        date = map['date'],
        startTime = map['start_time'],
        endTime = map['end_time'],
        serviceId = int.parse(map['service_id'].toString()),
        practionerUuid = map['practioner_uuid'],
        service = Service.fromMap(map['service'])
        ;
}
