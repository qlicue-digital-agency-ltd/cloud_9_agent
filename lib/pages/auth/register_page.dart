import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/models/user.dart';
import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:cloud_9_agent/pages/background/background.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode passwordConfirmFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool _obscureTextLogin = true;
  AuthProvider _authProvider ;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF6395e6),
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.white,
                          primaryColorDark: Colors.red[50],
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            } else
                              return null;
                          },
                          focusNode: emailFocusNode,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: (){
                              emailFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(passwordFocusNode);
                          },
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: "Email",
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 17.0,
                                  color: Colors.white),
                              prefixIcon: Icon(
                                FontAwesomeIcons.user,
                                size: 22.0,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.white,
                          primaryColorDark: Colors.red[50],
                        ),
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
                          textInputAction: TextInputAction.next,
                          onEditingComplete: (){
                            passwordFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(passwordConfirmFocusNode);
                          },
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Password",
                              labelText: "Password",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 17.0,
                                  color: Colors.white),
                              suffixIcon: InkWell(
                                onTap: () {
                                  print('object');
                                  setState(() {
                                    _obscureTextLogin = !_obscureTextLogin;
                                  });
                                },
                                child: Icon(
                                  _obscureTextLogin
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                              prefixIcon: Icon(
                                FontAwesomeIcons.lock,
                                size: 22.0,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.white,
                          primaryColorDark: Colors.red[50],
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please retype your password';
                            } else if(value.compareTo (passwordController.text) != 0) {

                            }
                            return null;
                          },
                          focusNode: passwordConfirmFocusNode,
                          controller: passwordConfirmController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          onEditingComplete: ()  {
                            FocusScope.of(context).unfocus();
                            _register();
                            },
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Password",
                              labelText: "Password Confirm",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 17.0,
                                  color: Colors.white),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _obscureTextLogin = !_obscureTextLogin;
                                  });
                                },
                                child: Icon(
                                  _obscureTextLogin
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                              prefixIcon: Icon(
                                FontAwesomeIcons.lock,
                                size: 22.0,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.blue,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: Colors.blueAccent,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: new LinearGradient(
                            colors: [Colors.deepOrange, Colors.blue],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Color(0xFF6395e6),
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 42.0),
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "WorkSansBold"),
                            ),
                          ),
                          onPressed: _register
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
                            Navigator.pushReplacementNamed(context, AppRoutes.LOGIN);
                          },
                          child: Text(
                            "Already have an account? Sign In!",
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

  void _register() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _authProvider
          .registerUser(
          email: emailController.text,
          password: passwordController.text)
          .then((response) {

            setState(() {
              _isLoading = false;
            });

        if(response['success']){
          _authProvider.setIsSignInUser = true;
          User user = response['user'];
          Navigator.of(context).pushReplacementNamed(AppRoutes.PROFILE);
        }else{
          showInSnackBar(response['message']);
        }


      });
    }
  }

  void showInSnackBar(String value) {
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
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}
