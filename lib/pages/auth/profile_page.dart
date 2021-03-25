import 'dart:io';

import 'package:cloud_9_agent/api/api.dart';
import 'package:image_picker/image_picker.dart';

import '../../provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();

  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  File _pickedImage;
  String _gender;
  AuthProvider _authProvider;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;

  final List<DropdownMenuItem> _genderList = [
    DropdownMenuItem(
      child: Text("MALE"),
      value: 'male',
    ),
    DropdownMenuItem(
      child: Text("FEMALE"),
      value: 'female',
    ),
  ];

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _genderFocusNode.dispose();

    passwordFocusNode.dispose();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF6395e6),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: AppBar(
                leading: Container(),
                elevation: 0,
                title: Text('Profile'),
                backgroundColor: Colors.transparent,
                actions: <Widget>[],
              ),
            ),
            Center(
                child: InkWell(
              onTap: () {
                chooseAmImage();
              },
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width / 2,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      _pickedImage == null
                          ? CircleAvatar(
                              radius: 60,
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          FileImage(_pickedImage),
                                      fit: BoxFit.cover)),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' Select menu Image!',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )),
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
                      return 'Please enter your full name';
                    } else
                      return null;
                  },
                  focusNode: _nameFocusNode,
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: (){
                    _nameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_genderFocusNode);
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
                      hintText: "Full Name",
                      labelText: "Full Name",
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
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black45)),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          FontAwesomeIcons.male,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Gender',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Spacer(),
                        DropdownButton(
                            iconEnabledColor: Colors.white,
                            // style: TextStyle(color: Colors.deepOrange),
                            underline: Container(),
                            focusNode: _genderFocusNode,
                            value: _gender,
                            items: _genderList,
                            onChanged: (value) => _genderDropdownButtonOnChange(value)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  )),
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
                      return 'Please enter your phone';
                    } else
                      return null;
                  },
                  focusNode: _phoneFocusNode,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: (){
                    _phoneFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_locationFocusNode);
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
                      ),
                      hintText: "Phone",
                      labelText: "Phone",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0,
                          color: Colors.white),
                      prefixIcon: Icon(
                        FontAwesomeIcons.phoneAlt,
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
                      return 'Please enter your location';
                    } else
                      return null;
                  },
                  focusNode: _locationFocusNode,
                  controller: _locationController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.send,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    _postProfile();

                    } ,
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
                      hintText: "location",
                      labelText: "location",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0,
                          color: Colors.white),
                      prefixIcon: Icon(
                        FontAwesomeIcons.locationArrow,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "Save & Proceed",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (_pickedImage != null) {
                        _postProfile();
                      } else {
                        showInSnackBar('Select profile Image');
                      }
                    }
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Divider(),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      )),
    );
  }

  void chooseAmImage() async {
    final picker = ImagePicker();
   PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);

   setState(() {
     _pickedImage = File(pickedFile.path);
   });


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
      backgroundColor: Colors.deepOrange,
      duration: Duration(seconds: 3),
    ));
  }

  _genderDropdownButtonOnChange(_selectedGender) {
    setState(() {
      _gender = _selectedGender;
    });
    FocusScope.of(context).requestFocus(_phoneFocusNode);

  }



  void _postProfile() async {

    if(_pickedImage?.path == null){
      showInSnackBar('Please chose and Image');
    }

    else if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });


      Map<String,dynamic> response = await  _authProvider.postProfileUser(location: _locationController.text, phone: _phoneController.text, name: _nameController.text, profilePicture: _pickedImage );

      setState(() {
        _isLoading = false;
      });

      if(response['success']){
        print('SSSSSSSSSSSSSSSSSSunccess');
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);

      }else{
        print('FFFFFFFFFFFFFFFFFFFFFFail');
        showInSnackBar(response['message']);

      }
    }




  }
}
