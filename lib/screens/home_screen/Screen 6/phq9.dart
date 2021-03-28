import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%202/constants.dart';
import 'package:project_app/screens/home_screen/Screen%206/Quiz.dart';
import 'package:project_app/screens/home_screen/Screen%206/result.dart';
import 'package:project_app/screens/home_screen/Screen%206/startphq.dart';

class phq9 extends StatefulWidget {
  @override
  _phq9State createState() => _phq9State();
}

class _phq9State extends State<phq9> {
  final _questions = const [
    {
      'questionText': 'Little interest or pleasure in doing things?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Feeling down, depressed, or hopeless?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText':
          'Trouble falling or staying asleep, or sleeping too much?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Feeling tired or having little energy?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': 'Poor appetite or overeating?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText':
          'Feeling bad about yourself - or that you are a failure or have let yourself or your family down?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText':
          'Trouble concentrating on things, such as reading the newspaper or watching television?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText':
          'Moving or speaking so slowly that other people could have noticed? Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText':
          'Thoughts that you would be better off dead, or of hurting yourself in some way?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Several days', 'score': 1},
        {'text': 'More than half the days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => startphq()));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              Text(
                "PHQ - 9",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => startphq()));
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: _questionIndex < _questions.length
                ? Quiz(
                    answerQuestion: _answerQuestion,
                    questionIndex: _questionIndex,
                    questions: _questions,
                  ) //Quiz
                : Center(child: Result(_totalScore, _resetQuiz)),
          ),
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}
