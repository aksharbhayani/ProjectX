import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_app/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../authentication/db.dart';
import 'package:project_app/screens/sign_in/components/sign_form.dart';
import 'grid_dash.dart';

final firestoreInstance = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;
bool themeSwitch = false;

dynamic themeColors() {
  bool condition = themeSwitch;
  if (condition) {
    return Colors.white;
  } else {
    return Color(0xff453658);
  }
}

dynamic textColors() {
  bool condition = themeSwitch;
  if (condition) {
    return Colors.black;
  } else {
    return Colors.white;
  }
}

dynamic shadowColors() {
  bool condition = themeSwitch;
  if (condition) {
    return Colors.grey[200];
  } else {
    return Color(0xff392850);
  }
}

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.00)),
              title: Text("Do you really want to exit the app?"),
              actions: [
                FlatButton(
                  child: Text("No",
                      style: TextStyle(
                          color: Color(0xFFC41A3B),
                          fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes",
                      style: TextStyle(
                          color: Color(0xFFC41A3B),
                          fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.pop(context, true),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: StreamProvider<QuerySnapshot>.value(
        value: DbService().users,
        child: Scaffold(
          backgroundColor: themeSwitch ? Colors.white : Color(0xff392850),
          body: Column(
            children: [
              SizedBox(height: 110),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey, $namee",
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              color: themeSwitch ? Colors.black : Colors.white,
                              fontSize: getScreenWidth(26),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    IconButton(
                      alignment: Alignment.topRight,
                      icon: themeSwitch
                          ? Icon(Icons.brightness_3)
                          : Icon(Icons.wb_sunny),
                      color: themeSwitch ? Colors.black : Colors.white,
                      onPressed: () {
                        setState(() {
                          themeSwitch = !themeSwitch;
                          themeColors();
                          textColors();
                          shadowColors();
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GridDashboard(themeColors, textColors, shadowColors),
            ],
          ),
        ),
      ),
      onWillPop: _onBackPressed,
    );
  }
}
