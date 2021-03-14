import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  primaryColorDark: Colors.white,
  accentColor: Color(0xff4F4F4F),
  // canvasColor: Colors.transparent,
  fontFamily: 'Roboto',

  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(
        fontSize: 14.0, fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
  ),

  scaffoldBackgroundColor: Color(0xFF1E1E1E),
  appBarTheme: AppBarTheme(
    color: Color(0xFF1E1E1E),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.black,
    primaryVariant: Colors.black,
    secondary: Colors.red,
  ),
  cardTheme: CardTheme(
    color: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Colors.white54,
  ),

  // bottomSheetTheme: BottomSheetThemeData(
  //     backgroundColor: Colors.transparent,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(10)))),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  primaryColorDark: Colors.white,
  accentColor: Color(0xff4F4F4F),
  // canvasColor: Colors.transparent,
  fontFamily: 'Roboto',

  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline2: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline3: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    subtitle1: TextStyle(fontSize: 14.0, color: Colors.white54),
    subtitle2: TextStyle(fontSize: 14.0, color: Colors.white54),
    bodyText1: TextStyle(
        fontSize: 14.0, fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
    bodyText2: TextStyle(
        fontSize: 14.0, fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
    overline: TextStyle(fontSize: 14.0, color: Colors.white54),
    caption: TextStyle(fontSize: 14.0, color: Colors.white54),
    button: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  scaffoldBackgroundColor: Color(0xFF1E1E1E),
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    elevation: 0,
    color: Color(0xFF1E1E1E),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.blue,
    onPrimary: Colors.white,
    primaryVariant: Colors.black,
    secondary: Colors.red,
  ),
  cardTheme: CardTheme(
    color: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),

  // bottomSheetTheme: BottomSheetThemeData(
  //     backgroundColor: Colors.transparent,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(10)))),
);
