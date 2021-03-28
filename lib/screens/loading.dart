import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      child: Center(
        child: SpinKitWanderingCubes(
          color: kPrimColor,
          size: 50.0,
        ),
      ),
    );
  }
}
