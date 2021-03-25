import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final Color color;

  int quantity;
  bool isFavorite =false;

  Product(
      {@required this.id,
        @required this.name,
        @required this.description,
        @required this.price,
        @required this.quantity,
        @required this.image,
        this.color,
        this.isFavorite = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'quantity': quantity
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Product.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        name = map['name'],
        description = map['description'],
        quantity = map['quantity'],
        price = double.parse(map['price'].toString()),
        image = map['image'],
        color = Colors.white;
}