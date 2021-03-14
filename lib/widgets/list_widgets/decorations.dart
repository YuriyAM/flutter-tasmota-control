import 'package:flutter/material.dart';

BoxDecoration lightBulbCardDecoration =
    BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10));

Container dismissibleBackground = Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Icon(Icons.delete_forever,
        size: 50, color: Colors.white.withOpacity(0.5)));
