import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_app/screens/authentication/auth.dart';
import 'package:project_app/screens/sign_in/forgot_password/forgot_password.dart';
import 'package:project_app/screens/home_screen/home.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../loading.dart';
import 'form_error.dart';
import 'package:cool_alert/cool_alert.dart';

String namee;

class Logform extends StatefulWidget {
  @override
  _LogformState createState() => _LogformState();
}

class _LogformState extends State<Logform> {
  final AuthService _auth = AuthService();
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  bool loading = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                      setState(() {
                        errors.remove(kEmailNullError);
                      });
                    } else if (emailValidatorRegExp.hasMatch(value) &&
                        errors.contains(kInvalidEmailError)) {
                      setState(() {
                        errors.remove(kInvalidEmailError);
                      });
                    }
                    email = value;
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kEmailNullError)) {
                      setState(() {
                        errors.add(kEmailNullError);
                      });
                      return "";
                    } else if (!emailValidatorRegExp.hasMatch(value) &&
                        !errors.contains(kInvalidEmailError)) {
                      setState(() {
                        errors.add(kInvalidEmailError);
                      });
                      return "";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(0, getScreenWidth(20),
                            getScreenWidth(20), getScreenWidth(20)),
                        child: Image.asset(
                          "assets/icons/Mail.png",
                          height: getScreenWidth(18),
                        ),
                      )),
                ),
                SizedBox(
                  height: getScreenHeight(30),
                ),
                TextFormField(
                  obscureText: true,
                  onSaved: (newValue) => password = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kPassNullError)) {
                      removeError(error: kPassNullError);
                    } else if (value.length >= 8 &&
                        errors.contains(kShortPassError)) {
                      removeError(error: kShortPassError);
                    }
                    password = value;
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kPassNullError)) {
                      addError(error: kPassNullError);
                    } else if (value.length < 8 &&
                        !errors.contains(kShortPassError)) {
                      addError(error: kShortPassError);
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(0, getScreenWidth(20),
                            getScreenWidth(20), getScreenWidth(20)),
                        child: Image.asset(
                          "assets/icons/Lock.png",
                          height: getScreenWidth(18),
                        ),
                      )),
                ),
                SizedBox(
                  height: getScreenHeight(30),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: remember,
                      activeColor: kPrimColor,
                      onChanged: (value) {
                        setState(() {
                          remember = value;
                        });
                      },
                    ),
                    Text("Remember me"),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ForgotPassword.routeName),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                FormError(errors: errors),
                SizedBox(
                  height: getScreenHeight(20),
                ),
                SizedBox(
                  width: double.infinity,
                  height: getScreenHeight(50),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: kPrimColor,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        try {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  context, email, password);
                          if (result != null) {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Login Successfull!",
                              confirmBtnText: "Ok",
                            );
                            await Future.delayed(Duration(seconds: 3));

                            /*Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);*/
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeName,
                                (Route<dynamic> route) => false);
                          }
                        } catch (e) {}
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: getScreenWidth(18), color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
