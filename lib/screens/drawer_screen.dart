
import 'package:cloud_9_agent/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/auth_provider.dart';
import 'package:cloud_9_agent/screens/account_screen.dart';
import 'package:cloud_9_agent/screens/terms_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'help_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool _value2 = false;

  void _onChanged2(bool value) {
    setState(() => _value2 = value);
    print(_value2);
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    User user = _authProvider.authenticatedUser;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(color: Colors.blue),
      child: Container(
          child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(user?.avatar == null ? '' :user.avatar,),onBackgroundImageError: (object,stackTrace){},),
                  accountName: Text(user?.name == null ? "" : user.name),
                  accountEmail: Text(user?.email == null ? "" : user.email)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('CODE: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    // Spacer(),
                    Text(_authProvider.authenticatedUser.code,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
                  ],
                ),
              ),
              Material(
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountScreen(),
                        ));
                  },
                  leading: Icon(Icons.account_box),
                  title: Text('Account'),
                ),
              ),
              SizedBox(height: 2),
              Material(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 16,
                    ),
                    Icon(Icons.notifications, color: Colors.grey[600],),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SwitchListTile(
                        value: _value2,
                        onChanged: _onChanged2,
                        title: new Text('Notification',
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2),
              Material(
                child: ListTile(
                  onTap: () {
                    print('object');
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpScreen(),
                        ));
                  },
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                ),
              ),
              SizedBox(height: 2),
              Material(
                child: ListTile(
                  onTap: () {
                    print('object');
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditionsScreen(),
                        ));
                  },
                  leading: Icon(Icons.book),
                  title: Text('Terms & Conditions'),
                ),
              ),
              SizedBox(height: 2),
              Spacer(),
              Material(
                child: ListTile(
                  onTap: () {
                    _authProvider.setIsSignInUser = false;
                    SharedPreferences.getInstance().then((preference){
                      preference.clear();
                      Navigator.of(context).pushReplacementNamed('/');
                    });
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      )),
    );
  }
}
