import 'package:flutter/material.dart';
import 'package:project_app/screens/sign_in/components/sign_form.dart';
import 'package:project_app/screens/sign_in/components/social_cards.dart';
import 'package:project_app/size_config.dart';

import 'no_acc_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getScreenWidth(28),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Login with your email and password \nor with your social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                Logform(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialIcons(
                      icon: "assets/icons/google-icon.png",
                      press: () {},
                    ),
                    SocialIcons(
                      icon: "assets/icons/facebook-2.png",
                      press: () {},
                    ),
                    SocialIcons(
                      icon: "assets/icons/twitter.png",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: getScreenHeight(20),
                ),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
