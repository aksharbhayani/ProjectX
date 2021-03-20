import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/screens/sign_in/sign_in.dart';
import 'package:project_app/screens/sign_up/sign_up.dart';
import 'package:project_app/screens/splash_screen/components/splash_content.dart';
import 'package:project_app/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Hello Friend!",
      "image": "assets/images/splash-1.gif",
    },
    {
      "text": "Are you okay?",
      "image": "assets/images/spash-2.gif",
    },
    {
      "text": "Let me check your mind....",
      "image": "assets/images/spalsh.gif",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 8, top: 5),
              alignment: Alignment.topRight,
              /*child: IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(Icons.cancel_rounded),
                  color: Color(0xFFD8D8D8),
                  onPressed: () =>
                      Navigator.pushNamed(context, HomeScreen.routeName)),
              // padding: EdgeInsets.only(left: 100),*/
            ),
            Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]["text"],
                    image: splashData[index]["image"],
                  ),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
                child: Column(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        )),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: getScreenHeight(50),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: kPrimColor,
                        onPressed: () =>
                            Navigator.pushNamed(context, SignUp.routeName),
                        child: Text(
                          "New user? Sign Up",
                          style: TextStyle(
                              fontSize: getScreenWidth(18),
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: getScreenHeight(50),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: kPrimColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        child: Text(
                          "Already Registered? Login",
                          style: TextStyle(
                              fontSize: getScreenWidth(18),
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
