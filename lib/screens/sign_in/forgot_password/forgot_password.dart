import 'package:flutter/material.dart';
import 'package:project_app/screens/sign_in/forgot_password/components/body.dart';

class ForgotPassword extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Body(),
    );
  }
}
