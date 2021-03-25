import 'package:cloud_9_agent/models/customer.dart';
import 'package:cloud_9_agent/models/service.dart';
import 'package:flutter/material.dart';

class Booking {
  final int id;
  bool isMyBooking;
  String startTime;
  String endTime;
  String date;
  String status;
  Service service;

  Booking(
      {@required this.id,
      @required this.startTime,
      @required this.date,
      @required this.endTime,
      @required this.service});
}

List<Booking> bookingList = <Booking>[
  Booking(
      id: 1,
      date: '2020-01-09',
      startTime: '07:05:00',
      endTime: '11:30:00',
    service: Service(id: 1, title: 'Title', body: 'Body')
  ),

];
