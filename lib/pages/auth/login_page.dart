import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_9_agent/pages/background/background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //AuthProvider _authProvider; // = Provider.of<AuthProvider>(context);
  // bool _isLoaded;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureTextLogin = true;

  // _LoginPageState() {
  //   _isUserData().then((isAvailable) => () {
  //         if (isAvailable) {
  //           print('Available');
  //         } else {
  //           print('Not available');
  //         }
  //       });
  // }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   _isLoaded = false;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);

//    _isUserData();
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Color(0xFF6395e6),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new Image(
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.fill,
                      image: new AssetImage(
                          'assets/icons/cloud9_transparent_logo.png')),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: Text('CLOUD9 CLINIC AGENT',
                      style: TextStyle(
                          fontFamily: 'trajanProRegular',
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: Color(0xFF6395e6),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 50.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Please enter your email';
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(value.trim()))
                                  return 'Please enter valid email';

                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (term) {
                                emailFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                              focusNode: emailFocusNode,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                fillColor: Colors.white,
                                prefixIcon: Material(
                                  elevation: 0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  child: Icon(
                                    Icons.mail_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 13),
                                hintText: "Email",
                                labelText: "Email",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 50.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your password';
                                } else
                                  return null;
                              },
                              focusNode: passwordFocusNode,
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.send,
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                _login(_authProvider);
                              },
                              obscureText: _obscureTextLogin,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Material(
                                  elevation: 0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  child: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                suffixIcon: InkWell(
                                  splashColor: Theme.of(context).primaryColor,
                                  highlightColor: Colors.transparent,
                                  child: Icon(_obscureTextLogin
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash),
                                  onTap: () {
                                    setState(() {
                                      _obscureTextLogin = !_obscureTextLogin;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 13),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  color: Colors.white,
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                        child: isLoading
                                            ? CircularProgressIndicator()
                                            : Text(
                                                "LOG IN",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontFamily: "WorkSansBold"),
                                              )),
                                  ),
                                  onPressed: () {
                                    _login(_authProvider);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "WorkSansMedium"),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.REGISTER);
                      },
                      child: Text(
                        "Don't have an account? Sign Up!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "WorkSansMedium"),
                      )),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  void _login(AuthProvider authProvider) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> response = await authProvider.signInUser(
          email: emailController.text, password: passwordController.text);

      setState(() {
        isLoading = false;
      });
      if (response['success']) {
        authProvider.setIsSignInUser = true;
        authProvider.setAuthenticatedUser = response['user'];
        showInSnackBar(response['message']);
        if (authProvider.authenticatedUser?.name == null)
          Navigator.pushReplacementNamed(context, AppRoutes.PROFILE);
        else
          Navigator.pushReplacementNamed(context, AppRoutes.HOME);
      } else {
        showInSnackBar('Login failed! ${response['message']}',color: Colors.red);
      }
    }
  }

  void showInSnackBar(String value,{Color color}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color ?? Colors.green,
      duration: Duration(seconds: 3),
    ));
  }

// Future<bool> _isUserData() async {
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//
//   setState(() {
//     _isLoaded = true;
//   });
//
//   print(preferences.containsKey(User.USER_JSON));
//   if (preferences.containsKey(User.USER_JSON)) {
//     try {
//       String userJson = preferences.getString(User.USER_JSON);
//
//       User user = User.fromMap(jsonDecode(userJson));
//
//       if(user.name == null) Navigator.pushReplacementNamed(context, AppRoutes.PROFILE);
//
//
//       _authProvider.setAuthenticatedUser = user;
//       _authProvider.setIsSignInUser = true;
//       Navigator.pushNamed(context, '/');
//       return true;
//     } catch (error) {
//       print('error occurred');
//       log(error.toString());
//       return false;
//     }
//   } else {
//     print('No User');
//     //Navigator.pushNamed(context, '/');
//     return false;
//   }
// }
}
