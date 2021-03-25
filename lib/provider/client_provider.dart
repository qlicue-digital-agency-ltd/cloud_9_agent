import 'dart:developer';

import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/models/customer.dart';
import 'package:cloud_9_agent/models/user.dart';
import 'package:flutter/material.dart';

import '../httpHandler.dart';
import 'auth_provider.dart';
import 'dart:developer';

class ClientProvider extends ChangeNotifier {
  AuthProvider _authProvider;
  User _authenticatedUser;


  update(AuthProvider authProvider) {
    _authProvider = authProvider;
    _authenticatedUser = authProvider.authenticatedUser;
  }

  bool isLoading = false;

  List<Client> clients = [];

  Future<Map<String, dynamic>> getAgentClients() async {
    //http://cloud9.qlicue.co.tz/server/api/agentClients/10

    isLoading = false;
    //notifyListeners();
    HttpData agentClients = await HttpHandler.httpGet(
        url: '${api}agentClients/${_authenticatedUser.id}');

    if (!agentClients.hasError) {
      Map<String, dynamic> clientsMap = agentClients.responseBody;

      // log(clientsMap.toString(), name: 'clients');

      clients.clear();
      try {
        for (Map<String, dynamic> client in clientsMap['agentClient']) {
          clients.add(Client(
              id: client['client']['id'],
              email: client['client']['email'],
              uuid: client['client']['profile']['uuid'],
              fullName: client['client']['profile']['fullname'],
              avatar: client['client']['profile']['avatar'],
            phone: '${client['client']['profile']['phone']}'
          ),);
        }
      } catch (error) {
        print(error);
        return {'success': false, 'message': 'Unexpected response'};
      }
    }
    isLoading = false;
    notifyListeners();

    return {'success': !agentClients.hasError, 'message': agentClients.message};
  }

  Future<List<User>> searchUser(String name) async {
    List<User> users = [];

    HttpData httpData = await HttpHandler.httpGet(
        url: '${api}search/users/$name');
    users.clear();
    httpData.responseBody['profiles'].forEach((profileMap) {
      users.add(
        User(
            id: int.parse('${profileMap['user_id']}'),
            email: '',
            name: profileMap['fullname'],
            token: '',
            avatar: profileMap['avatar'],
            code: profileMap['uuid']),
      );
    });

    if (users.isEmpty) return null;

    return users;
  }

  Future <Map<String, dynamic>> addClient(
      int clientId) async {

    HttpData httpData = await HttpHandler.httpPost(
        url: '${api}agentClient/${_authenticatedUser.code}', postBody: {'client_id': clientId});

    log(httpData.response.statusCode.toString(),name: 'Create Client');
    if (!httpData.hasError) {
      Map<String, dynamic> clientMap = httpData.responseBody['client'];
      clients.add(
          Client(
            id: clientMap['id'],
            email: clientMap['email'],
            uuid
            :clientMap['profile']['uuid'],
            fullName: clientMap['profile']['fullname'],
            avatar: clientMap['profile']['avatar'],
            phone: '${clientMap['profile']['phone']}'
          )
      );
      notifyListeners();
    }
    return {'hasError': httpData.hasError, 'message':httpData.message};
  }

  Future <Map<String, dynamic>> addClientByCode(
      {@required String clientCode}) async {
    if(!_authProvider.isAgent){
      return {'hasError': true,'message': 'You are Not authorized to be an Agent',};
    }
    log(_authenticatedUser.id.toString(),name: 'THe Agent');
    HttpData httpData = await HttpHandler.httpPost(
        url: '${api}addClient', postBody: {'client_code': clientCode,'agent_id': _authenticatedUser.id});

    log(httpData.response.statusCode.toString(),name: 'Create Client');
    if (!httpData.hasError) {
      if(httpData.responseBody['status']) {
        Map<String, dynamic> clientMap = httpData.responseBody['client'];
        clients.add(
            Client(
                id: clientMap['id'],
                email: clientMap['email'],
                uuid
                    : clientMap['profile']['uuid'],
                fullName: clientMap['profile']['fullname'],
                avatar: clientMap['profile']['avatar'],
                phone: '${clientMap['profile']['phone']}'
            )
        );
        notifyListeners();
        return {'hasError': !httpData.responseBody['status'], 'message':httpData.responseBody['message']};
      }else{
        return {'hasError': !httpData.responseBody['status'], 'message':httpData.responseBody['message']};
      }

    }

    return {'hasError': httpData.hasError, 'message':httpData.message};
  }
}
