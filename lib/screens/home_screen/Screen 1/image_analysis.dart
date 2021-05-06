import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%201/choose.dart';

class ImageAnalysis extends StatefulWidget {
  static String routeName = "/image_analysis";
  @override
  _ImageAnalysisState createState() => _ImageAnalysisState();
}

class _ImageAnalysisState extends State<ImageAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChooseOption(),
    );
  }
}
