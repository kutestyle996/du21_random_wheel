import 'dart:async';
import 'dart:math';

import 'package:du21_random_wheel/constants.dart';
import 'package:du21_random_wheel/member_filter.dart';
import 'package:du21_random_wheel/member_page.dart';
import 'package:flutter/material.dart';
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
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _getMembers();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: listMembers.length <= 1
          ? Container()
          : GestureDetector(
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
                    physics: CircularPanPhysics(
                      duration: Duration(seconds: 1),
                      curve: Curves.decelerate,
                    ),
                    items: [
                      for (var it in listMembers)
                        if(it.isSelected)
                        FortuneItem(
                          child: Text(it.name),
                        )
                    ],
                    animateFirst: false,
                        onAnimationEnd: () {
                          print('end end end');
                    },
                  ))
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _memberPage,
        tooltip: 'Add member',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _memberPage() {
    Navigator.of(context)
        .push(new MaterialPageRoute<String>(
            builder: (context) => MemberPage(listMembers)))
        .then((value) => setState(() => {_getMembers()}));
  }

  _getMembers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? members = prefs.getString(MEMBERS);
    if (members != null && members.isNotEmpty) {
      this.listMembers = MemberFilter.decode(members);
    }
  }
}
