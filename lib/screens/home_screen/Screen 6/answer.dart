import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen/Screen%202/constants.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      child: RaisedButton(
        shape: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[600]),
          borderRadius: BorderRadius.circular(getScreenWidth(15)),
        ),
        color: Colors.white70,
        //kPrimaryColor.withOpacity(0.9),
        textColor: Colors.black,

        highlightColor: Colors.green.shade400,

        child: Text(answerText),
        onPressed: selectHandler,
      ), //RaisedButton
    ); //Container
  }
}
