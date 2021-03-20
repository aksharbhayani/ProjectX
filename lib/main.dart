import 'package:flutter/material.dart';
import 'package:project_app/screens/routes.dart';
import 'package:project_app/themes.dart';
import './screens/splash_screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PJX',
        theme: theme(),
        //home: SplashScreen(),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
      onWillPop: _onBackPressed,
    );
  }
}
