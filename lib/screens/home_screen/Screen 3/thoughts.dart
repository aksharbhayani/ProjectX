import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Thoughts extends StatefulWidget {
  @override
  _ThoughtsState createState() => _ThoughtsState();
}

class _ThoughtsState extends State<Thoughts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Thoughts',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimColor, fontSize: getScreenWidth(40))),
      ),
    );
  }
}
