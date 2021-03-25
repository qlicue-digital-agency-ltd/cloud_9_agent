import 'dart:convert';

import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/models/user.dart';
import 'package:cloud_9_agent/pages/auth/profile_page.dart';
import 'package:cloud_9_agent/pages/auth/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './pages/auth/login_page.dart';
import './provider/auth_provider.dart';
import './screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:async/async.dart';

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);



    return FutureBuilder(
      future: hasUser(_authProvider),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        if(snapshot.hasData){

          print ('Is SigneInUser: ${_authProvider.isSignInUser}');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cloud 9 Agent',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:  !_authProvider.isSignInUser ?  LoginPage()  : ( _authProvider.authenticatedUser.name == 'null' ? ProfilePage() : HomeScreen())  ,
            routes: {
              AppRoutes.LOGIN: (BuildContext context) => LoginPage(),
              AppRoutes.REGISTER: (BuildContext context) => RegisterPage(),
              AppRoutes.PROFILE: (BuildContext context) => ProfilePage(),
            },
          );
        }else{
          print('SNAPSHOT hasData (else)');
          return MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator(),),)
          );
        }


      },
      // child:
    );
  }

   Future<dynamic> hasUser(AuthProvider authProvider) {

     return this._memoizer.runOnce(() async {
       SharedPreferences sharedPreferences = await SharedPreferences
           .getInstance();
       bool _hasUser = false;
       if (sharedPreferences.containsKey(User.USER_JSON)) {
         try {
           User user = User.fromMap(
               jsonDecode(sharedPreferences.getString(User.USER_JSON)));
           authProvider.setIsSignInUser = true;
           authProvider.setAuthenticatedUser = user;
           _hasUser = true;
           if(sharedPreferences.containsKey(User.IS_AGENT))
             authProvider.setIsAgent = sharedPreferences.getBool(User.IS_AGENT);
           else authProvider.setIsAgent = false;
         } catch (error) {
           authProvider.setIsSignInUser = false;
         }
       } else {
         authProvider.setIsSignInUser = false;
       }
       return _hasUser;
     });
  }
}

