import 'package:flutter/material.dart';

import 'background.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _value2 = false;

  void _onChanged2(bool value) {
    setState(() => _value2 = value);
    print(_value2);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Account',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 15,
              ),
              ListTile(
                leading: const Icon(Icons.lock, color: Colors.deepOrange),
                title: Text('Reset Password'),
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Account'),
                onTap: () {
                  _showDialog(context);
                },
              ),
              Divider(),
              SwitchListTile(
                value: _value2,
                onChanged: _onChanged2,
                title: new Text('Deactivate Account',
                    style: new TextStyle(fontWeight: FontWeight.bold)),
              ),
              Divider(),
            ])),
          ],
        ),
      ),
    ));
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Delete Account?"),
          content: Text("This will permanently delete your acount"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }
}
