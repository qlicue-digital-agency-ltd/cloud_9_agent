import 'package:cloud_9_agent/models/consultation.dart';
import 'package:cloud_9_agent/models/procedure.dart';
import 'package:flutter/material.dart';

import 'image.dart';

class Service {
  final int id;
  final String title;
  final String body;
  final int categoryId;
  List<ServiceImage> images = [];
  List<Procedure> procedures = [];
  List<Consultation> consultations = [];

  Service({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.categoryId,
    @required this.procedures,
    @required this.consultations,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'body': body,
      'category_id': categoryId,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Service.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        body = map['body'],
        categoryId = int.parse(map['category_id'].toString()),
        images = map['images'] != null
            ? (map['images'] as List)
                .map((i) => ServiceImage.fromMap(i))
                .toList()
            : [];
        // consultations = map['consultations'] != null
        //     ? (map['consultations'] as List)
        //         .map((i) => Consultation.fromMap(i))
        //         .toList()
        //     : [],
        // procedures = map['procedures'] != null
        //     ? (map['procedures'] as List).map((i) {
        //         print('00000');
        //         print(i.toString().length);
        //         return Procedure.fromMap(i);
        //       }).toList()
        //     : [];
}
