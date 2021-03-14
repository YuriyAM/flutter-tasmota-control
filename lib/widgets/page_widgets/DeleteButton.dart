import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/services/DatabaseProvider.dart';

class DeleteButton extends StatefulWidget {
  final LightBulb lightBulb;
  DeleteButton({this.lightBulb});
  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  DatabaseProvider dbProvider = DatabaseProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 5),
        child: InkWell(
          onTap: () {
            dbProvider.deleteLB(widget.lightBulb);
            Navigator.of(context).pop();
          },
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Ink(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.red),
              child: Center(
                  child: Text("Delete",
                      style: Theme.of(context).textTheme.button))),
        ));
  }
}

TextStyle infoTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
TextStyle delete = TextStyle(color: Colors.white, fontSize: 14);
