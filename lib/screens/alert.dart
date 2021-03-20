import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_app/screens/authentication/auth.dart';
import 'package:project_app/screens/sign_in/sign_in.dart';
import '../main.dart';

enum DialogAction { yes, cancel }
enum RetryDialog { retry }
enum ExitDialogAction { yes, cancel }

class RetryErrorDialogs {
  static Future<RetryDialog> retryerrDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.00)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () =>
                    Navigator.pushNamed(context, SignInScreen.routeName),
                child: Text('Retry',
                    style: TextStyle(
                        color: Color(0xFFC41A3B), fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
    return (action != null) ? action : RetryDialog.retry;
  }
}

class AlertDialogs {
  static Future<DialogAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final AuthService _auth = AuthService();
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.00)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.cancel),
                child: Text('Cancel',
                    style: TextStyle(
                        color: Color(0xFFC41A3B), fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                onPressed: () async {
                  await _auth.signOut().then((result) {
                    Fluttertoast.showToast(
                      msg: "Successfully Logged Out!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                        (route) => false);
                  });
                },
                child: Text('Log out',
                    style: TextStyle(
                        color: Color(0xFFC41A3B), fontWeight: FontWeight.w700)),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.cancel;
  }
}

class ExitAlertDialogs {
  static Future<ExitDialogAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.00)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () =>
                    Navigator.of(context).pop(ExitDialogAction.cancel),
                child: Text('No',
                    style: TextStyle(
                        color: Color(0xFFC41A3B), fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes',
                    style: TextStyle(
                        color: Color(0xFFC41A3B), fontWeight: FontWeight.w700)),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.cancel;
  }
}
