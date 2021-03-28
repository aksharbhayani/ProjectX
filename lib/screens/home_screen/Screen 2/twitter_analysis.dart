import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%202/main1.dart';

class TwitterAnalysis extends StatefulWidget {
  static String routeName = "/image_analysis";
  @override
  _TwitterAnalysisState createState() => _TwitterAnalysisState();
}

class _TwitterAnalysisState extends State<TwitterAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MyAppTwitter());
  }
}
