import 'package:flutter/material.dart';

class Client {
  final int id;
  final String uuid;
  final String fullName;
  final String avatar;
  final String phone;
  final String email;
  bool isMyCustomer;

  Client({
    @required this.id,
    @required this.uuid,
    @required this.fullName,
    @required this.avatar,
    @required this.phone,
    @required this.email
  });

  static Client fromMap(Map<String, dynamic> clientMap){
    return Client(
        id : clientMap['id'],
        uuid : clientMap['profile']['uuid'],
        fullName : clientMap['profile']['fullname'],
        avatar : clientMap['profile']['avatar'],
        phone : "${clientMap['profile']['phone']}" ,
        email : clientMap['email'],
    );
  }

}
