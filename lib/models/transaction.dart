import 'package:cloud_9_agent/models/product.dart';
import 'package:cloud_9_agent/models/service.dart';
import 'package:cloud_9_agent/models/customer.dart';
import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final String uuid;
  final String title;
  String amount;
  String paymentType;
  String paidFor;
  Client customer;
  Product product;
  Service service;


  Transaction({@required this.id, @required this.uuid, @required this.title,@required this.customer, this.product,this.service});
}

List<Transaction> transactionList = <Transaction>[
  Transaction(id: 1, uuid: 'AB2109I', title: 'chale  removal',customer: Client(id: 1, uuid: 'cl001', fullName: 'name', avatar: '')),
  Transaction(id: 2, uuid: 'AG3439K', title: 'Acne  treatment',customer: Client(id: 1, uuid: 'cl001', fullName: 'name', avatar: '')),
  Transaction(id: 3, uuid: 'CD2370D', title: 'Hair implantation',customer: Client(id: 1, uuid: 'cl001', fullName: 'name', avatar: '')),
  Transaction(id: 4, uuid: 'NH3243P', title: 'wrinkles removal',customer: Client(id: 1, uuid: 'cl001', fullName: 'name', avatar: '')),
  Transaction(id: 5, uuid: 'POK324R', title: 'Lips  Injection',customer: Client(id: 1, uuid: 'cl001', fullName: 'name', avatar: '')),
];
