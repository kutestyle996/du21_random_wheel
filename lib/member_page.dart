import 'dart:html';

import 'package:du21_random_wheel/member_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'member_filter.dart';

class MemberPage extends StatefulWidget {
  List<MemberFilter> listMembers = List.empty();

  MemberPage(this.listMembers);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Label text',
                border: InputBorder.none,
              ),
              controller: _controller,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: GestureDetector(
              child: Text(
                'Add member',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () {
                widget.listMembers = [...widget.listMembers, MemberFilter(name: _controller.value.text, isSelected: false)];
                setState(() {
                  });
              },
            ),
          ),
          Expanded(
            child: GridView.count(shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                ...(widget.listMembers ?? []).map((e) => MemberItem(e.name, true,)).toList()
              ]
            ),
          )
        ],
      ),
    );
  }

  _saveMembers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(widget.listMembers != null) {
      prefs.setString(MEMBERS, MemberFilter.encode(widget.listMembers));
    }
  }
}
