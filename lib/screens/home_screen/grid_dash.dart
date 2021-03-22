import "package:flutter/material.dart";
import 'package:project_app/screens/alert.dart';
import 'package:project_app/screens/home_screen/Screen%201/image_analysis.dart';
import 'package:project_app/screens/home_screen/Screen%203/thoughts.dart';
import 'package:project_app/size_config.dart';
import 'Screen 2/twitter_analysis.dart';
import 'Screen 4/reports.dart';
import 'Screen 5/daily_facts.dart';
import 'Screen 6/settings.dart';
import 'Screen 7/profile.dart';

// ignore: must_be_immutable
class GridDashboard extends StatefulWidget {
  final Function change;
  final Function txtchange;
  final Function shadowchange;

  GridDashboard(this.change, this.txtchange, this.shadowchange);

  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  bool tappedYes = false;

  Items item1 = new Items(
      no: "1", title: "Face\nAnalysis", img: "assets/images/facial-1.png");

  Items item2 = new Items(
      no: "2", title: "Twitter\nAnalysis", img: "assets/images/twitter.png");

  Items item3 = new Items(
      no: "3", title: "Thoughts", img: "assets/images/thoughts-3.png");

  Items item4 =
      new Items(no: "4", title: "Reports", img: "assets/images/Reports-4.png");

  Items item5 = new Items(
      no: "5", title: "Daily\nFacts", img: "assets/images/facts-5.png");

  Items item6 =
      new Items(no: "6", title: "Settings", img: "assets/images/setting.png");

  Items item7 =
      new Items(no: "7", title: "Profile", img: "assets/icons/profile.png");

  Items item8 =
      new Items(no: "8", title: "Logout", img: "assets/icons/logout.png");

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8
    ];

    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
                color: widget.change(),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: widget.shadowchange(),
                      offset: const Offset(10, 15),
                      blurRadius: 1.5,
                      spreadRadius: 0.5)
                ]),
            child: FlatButton(
              onPressed: () async {
                if (data.no == '1') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImageAnalysis()));
                } else if (data.no == '2') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TwitterAnalysis()));
                } else if (data.no == '3') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Thoughts()));
                } else if (data.no == '4') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Reports()));
                } else if (data.no == '5') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DailyFacts()));
                } else if (data.no == '6') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                } else if (data.no == '7') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                } else if (data.no == '8') {
                  final action = await AlertDialogs.yesCancelDialog(context,
                      'Confirm Logout', 'Are you sure you want to Logout?');
                  if (action == DialogAction.yes) {
                    setState(() => tappedYes = true);
                  } else {
                    setState(() => tappedYes = false);
                  }

                  /*CoolAlert.show(
                    context: context,
                    type: CoolAlertType.confirm,
                    text: "Do you want to logout",
                    confirmBtnText: "Yes",
                    cancelBtnText: "No",
                    confirmBtnColor: Colors.green,
                    onCancelBtnTap: () => Navigator.pop(context),
                    // ignore: missing_return
                    onConfirmBtnTap: await _auth.signOut().then((result) {
                      Fluttertoast.showToast(
                        msg: "Successfully Logged Out!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    }),
                  );*/
                }
                //print("Clicked  ${data.no} ");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    data.img,
                    width: 56,
                    height: 56,
                  ),
                  SizedBox(height: 25),
                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Muli",
                        color: widget.txtchange(),
                        fontSize: getScreenWidth(18),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Items {
  String title;
  String img;
  String no;
  Items({this.title, this.img, this.no});
}
