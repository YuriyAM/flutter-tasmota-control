import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasmota_control/pages/LightBulbListPage.dart';
import 'package:tasmota_control/pages/LightBulbPage.dart';
import 'package:tasmota_control/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF1E1E1E),
      systemNavigationBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tasmota Controller",
      initialRoute: '/',
      theme: darkTheme,
//      darkTheme: darkTheme,
      routes: {
        '/': (context) => LightBulbListPage(),
        '/LightBulbPage': (context) => LightBulbPage()
      },
    );
  }
}
