import 'package:flutter/material.dart';
import 'package:cloud_9_agent/models/user.dart';
import 'package:cloud_9_agent/httpHandler.dart';
import 'package:cloud_9_agent/api/api.dart';
import 'package:cloud_9_agent/screens/customer_screen.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SearchUsers extends SearchDelegate {
  CustomerScreen customerScreen;
  User selectedUser;
  final List<User> usersSuggested = [];
  String oldValue = '';
  final clientProvider;
  String searchFieldLabel = 'Customer Name';

  SearchUsers(this.clientProvider);

  @override
  List<Widget> buildActions(BuildContext context) {
    // // TODO: implement buildActions
    // throw UnimplementedError();
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // // TODO: implement buildLeading
    // throw UnimplementedError();
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, selectedUser);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // // TODO: implement buildResults
    // throw UnimplementedError();
    if (selectedUser == null) return searchBody();

    return Center(
        child: Card(
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50,
              child: Image.network(selectedUser.avatar,errorBuilder: (context,object,stackTrace) => Icon(Icons.person,size: 100,)),
            ),
          ),
          Divider(),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Name: " + selectedUser.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Code: ${selectedUser.code}"),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  child: Text(
                    'Add Client',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    clientProvider.addClient(selectedUser.id).then((response){
                      if(!response['hasError']){
                        showSuggestions(context);
                      }
                    });
                  },
                ),

                RaisedButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    query = '';
                    selectedUser = null;
                    showSuggestions(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return searchBody();

    search(query);
    return SingleChildScrollView(
      child: Column(
        children: usersSuggested.map((user) {
          return ListTile(
            title: Text(user.name),
            onTap: () {
              query = user.name;
              selectedUser = user;
              showResults(context);
            },
          );
        }).toList(),
      ),
    );
  }

  Future<HttpData> search(String name) async {
    if (query.isEmpty) {
      usersSuggested.clear();
      return null;
    }
    HttpData httpData =
        await HttpHandler.httpGet(url: '${api}search/users/$name');
    usersSuggested.clear();
    httpData.responseBody['profiles'].forEach((profileMap) {
      usersSuggested.add(
        User(
            id: int.parse('${profileMap['user_id']}'),
            email: '',
            name: profileMap['fullname'],
            token: '',
            avatar: profileMap['avatar'],
            code: profileMap['uuid']),
      );
    });
    return httpData;
  }

  Widget searchBody() {
   return FutureBuilder(
      future: clientProvider.searchUser(query),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        return SingleChildScrollView(
          child: StickyHeader(
            header: (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
                child:
                LinearProgressIndicator(backgroundColor: Colors.blue))
                : Container(),
            content: snapshot.hasData
                ? Column(
              children: snapshot.data.map((user) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(user.name),
                  onTap: () {
                    query = user.name;
                    selectedUser = user;
                    showResults(context);
                  },
                );
              }).toList(),
            )
                : (snapshot.connectionState == ConnectionState.done ||
                snapshot.connectionState == ConnectionState.none)
                ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 16),
                child: Text('No Match Found'),
              ),
            )
                : Container(),
          ),
        );
      },
    );
  }

}
