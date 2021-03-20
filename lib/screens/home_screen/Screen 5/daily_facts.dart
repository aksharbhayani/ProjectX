import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class DailyFacts extends StatefulWidget {
  @override
  _DailyFactsState createState() => _DailyFactsState();
}

class _DailyFactsState extends State<DailyFacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Daily Facts\nUnder maintenance',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimColor, fontSize: getScreenWidth(40))),
      ),
    );
  }
}
