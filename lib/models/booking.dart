import 'package:flutter/material.dart';

class Booking {
  final int id;
  final String name;
  final String date;
  final String time;
  bool isMyBooking;

  Booking({
    @required this.id,
    @required this.name,
    @required this.date,
    @required this.time,
  });
}

List<Booking> bookingList = <Booking>[
  Booking(
      id: 1,
      name: 'HAIR RESTORATION',
      date: '09 jan 2020',
      time: '7 am - 10 am'),
  Booking(
      id: 2,
      name: 'Lip microblading',
      date: '20 Agust 2020',
      time: '12 am - 04 pm'),
  Booking(
      id: 3,
      name: 'PERMANENT HAIR REMOVAL',
      date: '19 July 2020',
      time: '04 pm - 07 pm')
];
