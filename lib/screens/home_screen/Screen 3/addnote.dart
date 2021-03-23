import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_app/screens/authentication/auth.dart';

String title;
String content;
TextEditingController tittleControl = TextEditingController();
TextEditingController contentControl = TextEditingController();

class Addnote extends StatelessWidget {
  final AuthService _auth = AuthService();
  static String routeName = "/Addnote";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                dynamic result = await _auth.notesData();
                if (result != null) {
                  Fluttertoast.showToast(
                    msg: "Successfully Saved!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              child: Text("Save"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: tittleControl,
                decoration: InputDecoration(hintText: "Tittle"),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                child: TextField(
                  controller: contentControl,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: "Content"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
