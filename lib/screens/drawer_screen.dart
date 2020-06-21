
import 'package:flutter/material.dart';

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
                      backgroundImage: AssetImage('assets/images/lisa.jpeg')),
                  accountName: Text('Hawa Ally'),
                  accountEmail: Text('kalrobbynson@gmail.com')),
              Material(
                child: ListTile(
                  onTap: () {
                    print('object');
                    Navigator.pop(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AccountScreen(),
                    //     ));
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => HelpScreen(),
                    //     ));
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => TermsAndConditionsScreen(),
                    //     ));
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
                    print('object');
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
