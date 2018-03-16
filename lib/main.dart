import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_api_flutter_demo/strings.dart';
import 'package:http/http.dart' as http;

void main() =>
    runApp(new MaterialApp(title: Strings.appName, home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var _members = [];

  @override
  void initState() {
    super.initState();
    _loadUsersFromGitHub();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(Strings.appName),),
      body: new Container(
        child: new ListView.builder(
          itemCount: _members.length * 2 /*including dividers*/,
            itemBuilder: (BuildContext context, int position) {
              if(position.isOdd) return new Divider();
              var index = position ~/2;/*integer division*/
              return new Padding(
                padding: new EdgeInsets.all(20.0),
                child: new ListTile(
                  title: new Text(_members[index]["login"], style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.pink,
                    backgroundImage: new NetworkImage(_members[index]["avatar_url"]),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _loadUsersFromGitHub() {
    String url = "https://api.github.com/orgs/raywenderlich/members";
    http.get(url).then((response) {
      print(_members);
      setState(() {
        _members = JSON.decode(response.body);
      });
    });
  }
}

