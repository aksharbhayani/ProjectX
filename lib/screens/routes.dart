import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%201/image_analysis.dart';
import 'package:project_app/screens/home_screen/Screen%204/reports.dart';
import 'package:project_app/screens/home_screen/home.dart';
import 'package:project_app/screens/sign_in/forgot_password/forgot_password.dart';
import 'package:project_app/screens/sign_in/sign_in.dart';
import 'package:project_app/screens/sign_up/otp/otp.dart';
import 'package:project_app/screens/sign_up/profile/profile.dart';
import 'package:project_app/screens/sign_up/sign_up.dart';
import 'package:project_app/screens/splash_screen/splash.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
  SignUp.routeName: (context) => SignUp(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ImageAnalysis.routeName: (context) => ImageAnalysis(),
  Reports.routeName: (context) => Reports(),
};
