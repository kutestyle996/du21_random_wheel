import 'dart:async';

import 'package:du21_random_wheel/constants.dart';
import 'package:du21_random_wheel/member_filter.dart';
import 'package:du21_random_wheel/member_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'DU21 Random Wheel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MemberFilter> listMembers = List.empty();
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    // TODO: implement dispose
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getMembers();
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: listMembers.length < 1 ? Container() :  GestureDetector(
        onTap: () {
          setState(() {
            selected.add(Random().nextInt(listMembers.length));
          });
        },
        child: Column(
          children: [
            Expanded(
                child: FortuneWheel(
                  selected: selected.stream,
                  items: [
                    for(var it in listMembers) FortuneItem(
                        child: Text(it.name)
                    )
                  ],
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: _memberPage,
        tooltip: 'Add member',
        child: Icon(Icons.add),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _memberPage() {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemberPage(listMembers))
      );
  }

  _getMembers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? members = prefs.getString(MEMBERS);
    if(members != null && members.isNotEmpty) {
      this.listMembers = MemberFilter.decode(members);
    }
  }
}
