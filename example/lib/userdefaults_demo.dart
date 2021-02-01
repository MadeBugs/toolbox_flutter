import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/toolbox.dart';

class UserdefaultsDemoPage extends StatefulWidget {
  @override
  _UserdefaultsDemoPageState createState() => _UserdefaultsDemoPageState();
}

class _UserdefaultsDemoPageState extends State<UserdefaultsDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("本地存储"),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                UserDefaults().setMap('mapKey', {"admin": "admin"});
                UserDefaults().setString('stringKey', "admin");
                UserDefaults().setStringList('listKey', ['1', '2', '3']);
                UserDefaults().setInt('intKey', 100);
                UserDefaults().setDouble('doubleKey', 100.1234);
                UserDefaults().setBool('boolKey', false);
                UserDefaults().setList('list-test', [1, 2, 3, 'asdf']);
              },
              child: Text("Save")),
          TextButton(
              onPressed: () {
                print("""
            ${UserDefaults().getMap('mapKey')}
            ${UserDefaults().getString('stringKey')}
            ${UserDefaults().getStringList('listKey')}
            ${UserDefaults().getInt('intKey')}
            ${UserDefaults().getDouble('doubleKey')}
            ${UserDefaults().getBool('boolKey')}
            ${UserDefaults().getList('list-test')}""");
              },
              child: Text("Get")),
        ],
      ),
    );
  }
}
