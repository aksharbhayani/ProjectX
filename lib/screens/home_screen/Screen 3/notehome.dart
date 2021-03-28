import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/screens/home_screen/Screen%203/AddNotes.dart';
import 'package:project_app/screens/home_screen/Screen%203/viewnote.dart';
import 'package:project_app/screens/loading.dart';

class Notehome extends StatefulWidget {
  @override
  _NotehomeState createState() => _NotehomeState();
}

class _NotehomeState extends State<Notehome> {
  ScrollController _scrollController = new ScrollController();
  Query ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes')
      .orderBy('created', descending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNotes()))
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: kPrimColor,
      ),
      appBar: AppBar(
        backgroundColor: kPrimColor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      /*appBar: AppBar(
        centerTitle: true,
        title: Text("Thoughts",
            style: TextStyle(
                color: kPrimColor,
                fontSize: 26,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.bold)),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ), */
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(color: kPrimColor),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "THOUGHTS 💭",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Pen down your thoughts here\n It's safe with us ✌️ ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Muli",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
          Expanded(
            child: Container(
              height: (MediaQuery.of(context).size.height),
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: new ListView(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(
                          height: (MediaQuery.of(context).size.height),
                          child: FutureBuilder<QuerySnapshot>(
                            future: ref.get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      Map data =
                                          snapshot.data.docs[index].data();
                                      DateTime mydateTime =
                                          data['created'].toDate();
                                      String formattedTime = DateFormat.yMMMd()
                                          .add_jm()
                                          .format(mydateTime);

                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) => ViewNote(
                                                  data,
                                                  formattedTime,
                                                  snapshot.data.docs[index]
                                                      .reference),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10, top: 10),
                                          child: Card(
                                            color: Colors.lightBlue[900],
                                            elevation: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${data["title"]}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: "Open Sans",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "${data["description"]}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: "Open Sans",
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      formattedTime,
                                                      style: TextStyle(
                                                        color: Colors.white60,
                                                        fontSize: 14,
                                                        fontFamily: "Open Sans",
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                return Center(
                                  child: Loading(),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
