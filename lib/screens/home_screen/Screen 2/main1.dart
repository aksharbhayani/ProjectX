import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%202/constants.dart';
import 'package:project_app/screens/home_screen/Screen%202/screens/components/body.dart';
import 'package:project_app/screens/home_screen/Screen%202/screens/components/classifier.dart';
import 'package:project_app/screens/home_screen/home.dart';

class MyAppTwitter extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            gNegative.clear();
            gPositive.clear();
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (Route<dynamic> route) => false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
