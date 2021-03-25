import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_9_agent/httpHandler.dart';

import '../api/api.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User _authenticatedUser;
  bool _isSignInUser = false;
  bool _isAgent = false;

  PublishSubject<bool> _userSubject = PublishSubject();

  //getters

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  bool get isAgent => _isAgent;
  set setIsAgent(bool isAgent){
    _isAgent = isAgent;
    notifyListeners();
  }

  bool get isSignInUser => _isSignInUser;

  set setIsSignInUser(bool signedInState) {
    _isSignInUser = signedInState;
    notifyListeners();
  }

  set setAuthenticatedUser(User user) {
    _authenticatedUser = user;
    notifyListeners();
  }

  Future<void> autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    if (token != null) {
      final String userEmail = prefs.getString('email');
      final int userId = prefs.getInt('id');

      _authenticatedUser = User(
        id: userId,
        email: userEmail,
        token: token,
      );

      _userSubject.add(true);
    }

    notifyListeners();
  }

  Future<void> logout() async {
    userSubject.add(false);
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // prefs.remove('id');
    // prefs.remove('token');
    // prefs.remove('name');
    // prefs.remove('email');

    notifyListeners();
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  //Sign in User function..
  Future<Map<String, dynamic>> signInUser(
      {@required String email, @required String password}) async {
//    _isSignInUser = true;
//    notifyListeners();

    String _responseMessage = '';
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    HttpData response =
        await HttpHandler.httpPost(url: "${api}login", postBody: authData);

    log('${response.responseBody.toString()}',name: 'LOGIN RESPONSE');

    if (response.hasError) {
      return {
        'success': !response.hasError,
        'message': response.message,
        'networkError': response.networkError,
      };
    }

    if (response.responseBody.containsKey('access_token')) {
      var responseData = response.responseBody;
      log(responseData.toString(),name: 'LOGIN DATA');
      User user = User(
        id: responseData['user']['id'],
        email: responseData['user']['email'],
        token: responseData['access_token'],
        profileId: responseData['user']['profile']['id'],
        name: responseData['user']['profile']['fullname'],
        phone: '${responseData['user']['profile']['phone']}',
        avatar: responseData['user']['profile']['avatar'],
        code: responseData['user']['profile']['uuid'],
      );


      _authenticatedUser = user;

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(User.USER_JSON, user.toString());
      log(user.toString(),name: 'THE USER');
      String _msg = 'You have successfully log in';
//      if(responseData['user']['roles'].containsValue('Agent'))
        if(responseData['user']['roles'].indexWhere((role) => role['name'] == 'Agent') == -1){
          preferences.setBool(User.IS_AGENT, false);
          _isAgent = false;
          _msg = 'You are not an Agent, This app was for Cloud 9 agent user';
        }else{
          _isAgent = true;
          preferences.setBool(User.IS_AGENT, true);
        }


      return {'success': true, 'message': _msg , 'user': user};
    } else {
      String _message = '';
      if (response.responseBody.containsKey('error')) {
        _message = response.responseBody.containsKey('message')
            ? response.responseBody['message']
            : 'Login failed, check your email and password';
        return {'success': false, 'message': _message};
      }
    }
  }

  Future<Map<String, dynamic>> registerUser(
      {@required String email, @required String password}) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'role': ""
    };

    HttpData response = await HttpHandler.httpPost(
        url: "${api}signup", postBody: authData);


    if (response.hasError) {
      return {
        'success': !response.hasError,
        'message': response.message,
        'networkError': response.networkError,
      };
    } else {
      if (response.responseBody.containsKey('access_token') &&
          response.responseBody.containsKey('user')) {
        User user = User(
          id: response.responseBody['user']['id'],
          email: response.responseBody['user']['email'],
          token: response.responseBody['access_token'],
          profileId: response.responseBody['user']['profile']['id'],
          name: response.responseBody['user']['profile']['fullname'],
          phone: response.responseBody['user']['profile']['phone'],
          avatar: response.responseBody['user']['profile']['avatar'],
          code: response.responseBody['user']['profile']['uuid'],
        );

        _authenticatedUser = user;

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(User.USER_JSON, user.toString());

        return {
          'success': true,
          'message': '',
          'networkError': response.networkError,
          'user': user,
        };
      } else {
        return {
          'success': false,
          'message': response.responseBody['message'],
          'networkError': response.networkError,
        };
      }
    }
  }

  Future<Map<String, dynamic>> postProfileUser(
      {@required String location,
      @required String phone,
      @required String name,
      @required File profilePicture}) async {
    final Map<String, String> authData = {
      'location': location,
      'phone': phone,
      'fullname': name,
      'position': "Agent",
      'user_id': _authenticatedUser.id.toString(),
      'registration_number':"AG${(100000+_authenticatedUser.id).toString().substring(1)}"
    };

    HttpData response = await HttpHandler.httpSendDataWithImage(
        url: "${api}editProfile/${_authenticatedUser.profileId.toString()}",
        postBody: authData,
        filePath: profilePicture.path,
        fileKey: 'file',
        method: 'POST');

//    if (response.hasError) {
//      return {'success': !response.hasError, 'message': response.message};
//    }

    print(response.responseBody);
    if (response.responseBody.containsKey('user')) {
      var responseData = response.responseBody;
      log('XXXXXXXXXXX: ${responseData.toString()}');
      User user = User(
        id: responseData['user']['id'],
        email: responseData['user']['email'],
        token: responseData['access_token'],
        profileId: responseData['user']['profile']['id'],
        name: responseData['user']['profile']['fullname'],
        phone: '${responseData['user']['profile']['phone']}',
        avatar: responseData['user']['profile']['avatar'],
        code: responseData['user']['profile']['uuid'],
      );

      _authenticatedUser = user;


      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(User.USER_JSON, user.toString());

      return {'success': !response.hasError, 'message': response.message};
    } else {
      return {'success': false, 'message': response.message};
    }
  }
}
