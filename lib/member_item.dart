
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberItem extends StatefulWidget {
  String name;
  bool isSelected;

  MemberItem(this.name, this.isSelected);

  @override
  _MemberItemState createState() => _MemberItemState();
}

class _MemberItemState extends State<MemberItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isSelected = !widget.isSelected;
        setState(() {

        });
      },
      child: Container(
        child: widget.isSelected ? Container(
          alignment: Alignment.center,
          width: 1000,
          height: 1000,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              color: Colors.blueAccent
          ),
          child: Text(
            '${widget.name}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ) : Container(
          alignment: Alignment.center,
          width: 1000,
          height: 1000,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Text(
            '${widget.name}',
            style: Theme.of(context).textTheme.headline5,
          ),
        )
      ),
    );
  }
}
