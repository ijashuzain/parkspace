import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/authentication/signup_page.dart';
import 'package:parkspace/screens/home/home_main.dart';
import 'package:parkspace/widgets/auth_title.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/login_page";
  LoginPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            const AuthTitle("Login"),
            CTextField(
              controller: usernameController,
              hint: "Username",
            ),
            CTextField(
              controller: passwordController,
              hint: "Password",
            ),
            SizedBox(
              height: 5.h,
            ),
            SignupText(() {
              Navigator.pushNamed(context, SignupPage.routeName);
            }),
            SizedBox(
              height: 1.h,
            ),
            CButton(
              title: "Login",
              onTap: () {
                Navigator.pushNamed(context, HomePage.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}

class SignupText extends StatelessWidget {
  final VoidCallback onTap;
  const SignupText(
    this.onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't you have registered yet ? ",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 8.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: "Click here ",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 8.sp,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline),
            ),
            TextSpan(
              text: "to Signup now. ",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 8.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
