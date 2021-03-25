import 'package:flutter/material.dart';

class ServiceImage {
  final int id;
  final String url;
  final int serviceId;

  ServiceImage(
      {@required this.id, @required this.url, @required this.serviceId});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'service_id': serviceId, 'url': url};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  ServiceImage.fromMap(Map<String, dynamic> map)
      :
        id = map['id'],
        url = map['url'],
        serviceId = int.parse(map['service_id'].toString());
}
