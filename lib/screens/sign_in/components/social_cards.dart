import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getScreenWidth(10)),
        padding: EdgeInsets.all(getScreenWidth(12)),
        height: getScreenHeight(40),
        width: getScreenWidth(40),
        decoration:
            BoxDecoration(color: Color(0xFFF5F6F9), shape: BoxShape.circle),
        child: Image.asset(icon),
      ),
    );
  }
}
