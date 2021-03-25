import 'dart:developer';

import 'dart:convert';
import 'package:meta/meta.dart';

class User {
  static const USER_JSON = 'user';
  static const IS_AGENT = 'isAgent';

  final int id;
  final String email;
  final String token;
  final String name;
  String phone;
  String avatar;
  String code;
  int profileId;

  //bool isAgent;

  User(
      {@required this.id,
      @required this.token,
      @required this.email,
      @required this.name,
      //@required this.isAgent,
      this.phone,
      this.avatar,
      this.code,
      this.profileId});

  User.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['token'] != null),
        assert(map['email'] != null),
        assert(map['name'] != null),
        assert(map['avatar'] != null),
        assert(map['code'] != null),
        assert(map['phone'] != null),
        id = map['id'],
        token = map['token'].toString(),
        email = map['email'].toString(),
        name = map['name'],
        code = map['code'],
        phone = map['phone'],
        profileId = map['profile_id'],
        avatar = map['avatar'];

  @override
  String toString() {
    Map<String, dynamic> userMap = {
      "id": this.id,
      "email": this.email,
      "token": this.token,
      "name": this.name,
      "phone": this.phone,
      "avatar": this.avatar,
      "profile_id": this.profileId,
      "code": this.code,
    };

    return jsonEncode(userMap);
  }
}
