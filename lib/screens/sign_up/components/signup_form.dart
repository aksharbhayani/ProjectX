import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_app/screens/authentication/auth.dart';
import 'package:project_app/screens/sign_in/components/form_error.dart';
import 'package:project_app/screens/sign_in/sign_in.dart';
import 'package:project_app/screens/sign_up/otp/otp.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../loading.dart';

String name;
String phone;
String username;
String eemail;
String phoneno;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final ScrollController _controller1 = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  String conformPassword;
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
    if (errors.contains(error))
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: getScreenHeight(260),
                    child: Scrollbar(
                      controller: _controller1,
                      isAlwaysShown: true,
                      child: ListView(
                        controller: _controller1,
                        children: [
                          SizedBox(height: getScreenHeight(02)),
                          buildNameFormField(),
                          SizedBox(height: getScreenHeight(30)),
                          buildPhoneFormField(),
                          SizedBox(height: getScreenHeight(30)),
                          buildUserNameFormField(),
                          SizedBox(height: getScreenHeight(30)),
                          buildEmailFormField(),
                          SizedBox(height: getScreenHeight(30)),
                          buildPasswordFormField(),
                          SizedBox(height: getScreenHeight(30)),
                          buildConformPassFormField(),
                        ],
                      ),
                    ),
                  ),
                  FormError(errors: errors),
                  SizedBox(height: getScreenHeight(40)),
                  SizedBox(
                    width: double.infinity,
                    height: getScreenHeight(50),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: kPrimColor,
                      child: Text("Continue",
                          style: TextStyle(
                              fontSize: getScreenWidth(18),
                              color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result != null) {
                            Fluttertoast.showToast(
                              msg: "Successfully Registered!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                            );
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Image.asset("assets/icons/Lock.png"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Image.asset("assets/icons/Lock.png"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Image.asset("assets/icons/Mail.png"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
          return "";
        } else {
          return null;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Image.asset("assets/icons/Mail.png"),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
          return "";
        } else {
          return null;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Twitter Username",
        hintText: "Enter your Twitter Username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Image.asset("assets/icons/Mail.png"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.length == 10) {
          removeError(error: kPhoneNumberError);
          return "";
        } else {
          return null;
        }
      },
      validator: (value) {
        if (value.length != 10) {
          addError(error: kPhoneNumberError);
          return "";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "For eg: +91 1234567890",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Image.asset("assets/icons/Mail.png"),
      ),
    );
  }
}
