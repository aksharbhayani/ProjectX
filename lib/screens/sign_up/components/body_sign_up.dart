import 'package:flutter/material.dart';
import 'package:project_app/screens/sign_in/components/social_cards.dart';
import 'package:project_app/screens/sign_up/components/signup_form.dart';
import '../../../size_config.dart';

class BodySignUp extends StatelessWidget {
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
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Register Account",
                    style: TextStyle(
                        fontSize: getScreenWidth(28),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.5)),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
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
                SizedBox(height: getScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Terms and Conditions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
