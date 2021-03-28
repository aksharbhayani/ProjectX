import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen 2/constants.dart';
import 'package:project_app/screens/home_screen/Screen 2/screens/components/classifier.dart';
import 'package:project_app/screens/home_screen/Screen 2/screens/components/barChart.dart';
import "dart:async";
import 'package:project_app/screens/home_screen/Screen%202/twitter_analysis.dart';
import 'package:project_app/screens/sign_up/components/signup_form.dart';
import 'package:project_app/size_config.dart';
import '../../../../loading.dart';

bool positiveshow = false;
double neg = 0.0;
double pos = 0.0;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    bool pressAttention = false;
    Size size = MediaQuery.of(context).size;

    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          BarDays(),
        ],
      ),
    );
  }
}

class listbuild extends StatelessWidget {
  const listbuild({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gNegative.length == 0
        ? Container(child: Text("No Tweets"))
        : Column(
            children: <Widget>[
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: gNegative.length,
                itemBuilder: (context, int index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Text((index + 1).toString()),
                      title: Text(gNegative[index]),
                    ),
                  );
                },
              )
            ],
          );
  }
}

class listbuildneg extends StatelessWidget {
  const listbuildneg({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gNegative.length == 0
        ? Container(child: Text("No Tweets"))
        : Column(
            children: <Widget>[
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: gPositive.length,
                itemBuilder: (context, int index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Text((index + 1).toString()),
                      title: Text(gPositive[index]),
                    ),
                  );
                },
              )
            ],
          );
  }
}

class HeaderWithSearchBox extends StatefulWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _HeaderWithSearchBoxState createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  TextEditingController _controller;
  Classifier _classifier;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _classifier = Classifier();
    final text = username;
    final prediction = _classifier.classify(text);
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // It will cover 20% of our total height
      height: widget.size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: widget.size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Hi @$username!',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                    side: BorderSide(color: Colors.white)))),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        gNegative.clear();
                        gPositive.clear();
                        Navigator.pop(context); // pop current page
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TwitterAnalysis()));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarDays extends StatefulWidget {
  const BarDays({
    Key key,
  }) : super(key: key);

  @override
  _BarDaysState createState() => _BarDaysState();
}

class _BarDaysState extends State<BarDays> {
  Timer _timer;

  _BarDaysState() {
    _timer = new Timer(const Duration(milliseconds: 7000), () {
      Container(child: Loading());
      setState(() {
        neg = Classifier.positive;
        pos = Classifier.negative;
        print('this is $pos');
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    title: Text(
                      "@$username's Negative Tweets",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontSize: getScreenWidth(20)),
                    ),
                    content: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(child: listbuildneg()),
                      ],
                    ))));
          },
          child: NeumorphicBar(
            width: 200,
            height: 350,
            value: neg,
            text: 'Negative ' + (neg * 100).toInt().toString(),
            color: Color.fromRGBO(242, 84, 91, 1.0),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    title: Text(
                      "@$username's Positive Tweets",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontSize: getScreenWidth(20)),
                    ),
                    content: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(child: listbuild()),
                      ],
                    ))));
          },
          child: NeumorphicBar(
            width: 200,
            height: 350,
            value: pos,
            text: 'Positive ' + (pos * 100).toInt().toString(),
            color: Color.fromRGBO(0, 200, 156, 1.0),
          ),
        ),
      ],
    );
  }
}
