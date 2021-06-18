
import 'package:du21_random_wheel/member_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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
  var uuid = Uuid();
  void onRemove(uid) {
    setState(() {
      widget.listMembers.removeWhere((element) => element.id == uid);
      _saveMembers();
    });
  }

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
      body: Container(
        margin: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Name...',
                  border: InputBorder.none,
                ),
                controller: _controller,
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
                    setState(() {
                      widget.listMembers = [
                        ...widget.listMembers,
                        MemberFilter(
                            id: uuid.v1(),
                            name: _controller.value.text,
                            isSelected: true)
                      ];
                      _saveMembers();
                    });
                  },
                ),
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    ...(widget.listMembers ?? [])
                        .map((e) => MemberItem(e.id, e.name, e.isSelected, onRemove))
                        .toList()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop('String');
          },
          tooltip: 'Add member',
          child: Icon(Icons.save),
        )
    );
  }

  _saveMembers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(MEMBERS, MemberFilter.encode(widget.listMembers));
  }
}
