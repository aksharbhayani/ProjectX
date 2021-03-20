import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    appBarTheme: appBar(),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    textTheme: textTheme(),
    inputDecorationTheme: inputDecoration(),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecoration() {
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: OutlineInputBorder(
        //
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: kTextColor),
        gapPadding: 10),
    focusedBorder: OutlineInputBorder(
        //
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: kTextColor),
        gapPadding: 10),
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBar() {
  return AppBarTheme(
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      textTheme: TextTheme(
          headline6: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18)),
      iconTheme: IconThemeData(color: Colors.black));
}
