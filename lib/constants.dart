import 'package:flutter/material.dart';
import 'package:project_app/size_config.dart';

const kPrimColor = Color(0xFFFF7643);
const kPrimLightColor = Color(0xFFFFECDF);
const kprimGradColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please enter your Email";
const String kInvalidEmailError = "Please enter valid Email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kPhoneNumberError = "Mobile Number must be of 10 digit";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: getScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
