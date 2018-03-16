import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_api_flutter_demo/member.dart';
import 'package:github_api_flutter_demo/strings.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _members = <Member>[];

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
                  title: new Text(_members[index].userName, style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.pink,
                    backgroundImage: new NetworkImage(_members[index].profilePixUrl),
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
        var memberJson = JSON.decode(response.body);
        for(var memberNode in memberJson) {
          Member member = new Member(memberNode["login"], memberNode["avatar_url"]);
          _members.add(member);
        }
      });
    });
  }
}

