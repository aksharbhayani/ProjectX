import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%203/addnote.dart';
import 'package:project_app/screens/home_screen/Screen%203/notes.dart';

class Thoughts extends StatefulWidget {
  @override
  _ThoughtsState createState() => _ThoughtsState();
}

class _ThoughtsState extends State<Thoughts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addnote()));
          },
        ),
        body: notes());
  }
}
