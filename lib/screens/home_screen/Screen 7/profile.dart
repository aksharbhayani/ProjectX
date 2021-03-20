import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile\nUnder maintenance',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimColor, fontSize: getScreenWidth(40))),
      ),
    );
  }
}
