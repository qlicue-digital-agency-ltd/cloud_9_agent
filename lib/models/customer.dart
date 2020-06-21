import 'package:flutter/material.dart';

class Customer {
  final int id;
  final String uuid;
  final String fullname;
  final String avatar;
  bool isMyCustomer;

  Customer({
    @required this.id,
    @required this.uuid,
    @required this.fullname,
    @required this.avatar,
  });
}

List<Customer> customerList = <Customer>[
  Customer(
      id: 1,
      uuid: 'C93291PL',
      fullname: 'Mr Allison George',
      avatar: 'assets/images/matty.jpg'),
  Customer(
      id: 2,
      uuid: 'C93789UL',
      fullname: 'Mr Mason Greenwood',
      avatar: 'assets/images/rob.png'),
  Customer(
      id: 3,
      uuid: 'C99083PI',
      fullname: 'Ms Lissa Kato',
      avatar: 'assets/images/lisa.jpeg')
];
