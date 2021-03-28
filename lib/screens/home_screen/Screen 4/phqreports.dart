import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:project_app/screens/home_screen/Screen%204/reports.dart';
import '../../../constants.dart';
import '../../loading.dart';

class phqReports extends StatefulWidget {
  @override
  _phqReportsState createState() => _phqReportsState();
}

class _phqReportsState extends State<phqReports> {
  ScrollController _scrollController = new ScrollController();
  Query ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('phq-9 results')
      .orderBy('created', descending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimColor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: bodyy(scrollController: _scrollController, ref: ref),
    );
  }
}

class bodyy extends StatelessWidget {
  const bodyy({
    Key key,
    @required ScrollController scrollController,
    @required this.ref,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final Query ref;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    "PHQ - 9 Results",
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
                    "All your previous PHQ-9 reports ",
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
                                    Map data = snapshot.data.docs[index].data();
                                    DateTime mydateTime =
                                        data['created'].toDate();
                                    String formattedTime = DateFormat.yMMMd()
                                        .add_jm()
                                        .format(mydateTime);

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, top: 10),
                                      child: Card(
                                        color: Colors.lightBlue[900],
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Result: ${data["resultphrase"]}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: "Open Sans",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Score: ${data["resultscore"]}",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
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
    );
  }
}
