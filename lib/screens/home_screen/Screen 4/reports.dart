import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Reports\nUnder maintenance',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimColor, fontSize: getScreenWidth(40))),
      ),
    );
  }
}
