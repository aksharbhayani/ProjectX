import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xff070706),
        appBar: AppBar(
          elevation: 3,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              IconButton(
                onPressed: add,
                icon: Icon(
                  Icons.check_circle_outlined,
                  size: 30,
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Form(
                    child: Column(
                  children: [
                    new Theme(
                      data: new ThemeData(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration:
                              new InputDecoration.collapsed(hintText: 'Title'),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.bold),
                          onChanged: (_val) {
                            title = _val;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(8),
                      child: new Theme(
                        data: ThemeData(),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Description',
                              labelStyle:
                                  TextStyle(fontSize: 32, color: Colors.white)),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontFamily: "Open Sans",
                          ),
                          onChanged: (_val) {
                            description = _val;
                          },
                          maxLines: null,
                          expands: true,
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': description,
      'created': DateTime.now(),
    };

    ref.add(data);

    Navigator.pop(context);
  }
}
