import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%201/tensorflow.dart';
import 'package:project_app/screens/home_screen/Screen%201/video_analysis.dart';
import 'package:project_app/screens/home_screen/Screen%202/constants.dart';
import 'package:project_app/screens/home_screen/home.dart';

import '../../../constants.dart';

class ChooseOption extends StatefulWidget {
  @override
  _ChooseOptionState createState() => _ChooseOptionState();
}

class _ChooseOptionState extends State<ChooseOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Facial Analysis",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (Route<dynamic> route) => false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Text(
                          "Analysis Information",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("✦  "),
                            Expanded(
                              child: Text(
                                "We will analyze your facial data from your Images/Videos.",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("✦  "),
                            Expanded(
                              child: Text(
                                "We don't store any of your data in our system.",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    FloatingActionButton.extended(
                      heroTag: "btn1",
                      tooltip: 'Pick Image',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tensorflow()));
                      },
                      label: Text("Image Analysis"),
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 20,
                        color: Colors.white,
                      ),
                      backgroundColor: kPrimColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.extended(
                      heroTag: "btn2",
                      tooltip: 'Open Camera',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => videoAnalysis()));
                      },
                      label: Text("Video Analysis"),
                      icon: Icon(
                        Icons.video_library,
                        size: 20,
                        color: Colors.white,
                      ),
                      backgroundColor: kPrimColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
