import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final String uuid;
  final String title;

  Transaction({@required this.id, @required this.uuid, @required this.title});
}

List<Transaction> transactionList = <Transaction>[
  Transaction(id: 1, uuid: 'AB2109I', title: 'chale  removal'),
  Transaction(id: 2, uuid: 'AG3439K', title: 'Acne  treatment'),
  Transaction(id: 3, uuid: 'CD2370D', title: 'Hair implantation'),
  Transaction(id: 4, uuid: 'NH3243P', title: 'wrinkles removal'),
  Transaction(id: 5, uuid: 'POK324R', title: 'Lips  Injection'),
];
