import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberItem extends StatefulWidget {
  String name;
  bool isSelected;
  String id;
  Function onRemove;

  MemberItem(this.id, this.name, this.isSelected, this.onRemove);

  @override
  _MemberItemState createState() => _MemberItemState();
}

class _MemberItemState extends State<MemberItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      child: Stack(
        children: [
          Container(
              child: widget.isSelected
                  ? Container(
                      alignment: Alignment.center,
                      width: 1000,
                      height: 1000,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          color: Colors.blueAccent),
                      child: Text(
                        '${widget.name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      width: 1000,
                      height: 1000,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(30.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Text(
                        '${widget.name}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    )),
          Positioned(
            right: 24,
            top: 24,
            child: GestureDetector(
              child: Icon(Icons.highlight_remove_rounded,
                  color: widget.isSelected ? Colors.white : Colors.black),
              onTap: () {
                widget.onRemove(widget.id);
              },
            ),
          )
        ],
      ),
    );
  }
}
