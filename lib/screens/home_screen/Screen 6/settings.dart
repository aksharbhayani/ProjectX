import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Settings\nUnder maintenance',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimColor, fontSize: getScreenWidth(40))),
      ),
    );
  }
}
