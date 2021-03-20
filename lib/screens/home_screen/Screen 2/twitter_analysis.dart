import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/size_config.dart';

class TwitterAnalysis extends StatefulWidget {
  static String routeName = "/image_analysis";
  @override
  _TwitterAnalysisState createState() => _TwitterAnalysisState();
}

class _TwitterAnalysisState extends State<TwitterAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Twitter Analysis\nUnder maintenance',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimColor, fontSize: getScreenWidth(40))),
      ),
    );
  }
}
