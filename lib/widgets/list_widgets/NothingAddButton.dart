import 'package:flutter/material.dart';

class NothingAddButton extends StatefulWidget {
  final notifyParent;
  NothingAddButton({Key key, @required this.notifyParent}) : super(key: key);
  @override
  _NothingAddButtonState createState() => _NothingAddButtonState();
}

class _NothingAddButtonState extends State<NothingAddButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        "Add new Ligt Bulb",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => widget.notifyParent(),
      color: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF363540).withOpacity(0.95)),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
