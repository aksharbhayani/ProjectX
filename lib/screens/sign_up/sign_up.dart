import "package:flutter/material.dart";

import 'components/body_sign_up.dart';

class SignUp extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up"),
      ),
      body: BodySignUp(),
    );
  }
}
