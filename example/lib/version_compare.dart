import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/toolbox.dart';

class ToolsTestPage extends StatefulWidget {
  @override
  _ToolsTestPageState createState() => _ToolsTestPageState();
}

class _ToolsTestPageState extends State<ToolsTestPage> {
  @override
  void initState() {
    super.initState();
    if (ToolsKit.compareVersion("12.12.1", "12.8.2")) {
      print("true");
    } else {
      print('false');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
