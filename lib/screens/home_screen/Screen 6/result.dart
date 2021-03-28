import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_app/screens/home_screen/Screen%202/constants.dart';
import 'package:project_app/screens/home_screen/Screen%206/startphq.dart';

class Result extends StatelessWidget {
  int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

//Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 20 && resultScore <= 27) {
      resultText = 'Severe Depression 😔';
      print(resultScore);
    } else if (resultScore >= 15 && resultScore <= 19) {
      resultText = 'Moderately Severe Depression 🙁';
      print(resultScore);
    } else if (resultScore >= 10 && resultScore <= 14) {
      resultText = 'Moderate Depression 😐';
    } else if (resultScore >= 5 && resultScore <= 9) {
      resultText = 'Mild Depression 🙂';
    } else {
      resultText = 'No Depression 🤗';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            resultPhrase,
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ), //
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Score: ' '$resultScore',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),

          //Text
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor),
                ),
                child: Text(
                  'Save Results 💾',
                ), //Text

                onPressed: () {
                  add();
                  Fluttertoast.showToast(
                    msg: "Results Saved",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor),
                ),
                child: Text(
                  'Restart Quiz! 🔄',
                ), //Text

                onPressed: () {
                  resultScore = 0;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => startphq()));
                },
              ),
            ],
          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    );
  }

  void add() {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('phq-9 results');

    var data = {
      'resultscore': resultScore,
      'resultphrase': resultPhrase,
      'created': DateTime.now(),
    };

    ref.add(data);
  }
}
