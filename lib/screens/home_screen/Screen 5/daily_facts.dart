import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%205/body.dart';


class DailyFacts extends StatefulWidget {
  @override
  _DailyFactsState createState() => _DailyFactsState();
}

class _DailyFactsState extends State<DailyFacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CarouselDemo());
  }
}
