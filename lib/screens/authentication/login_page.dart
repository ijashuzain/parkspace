import 'dart:developer';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/auth_provider.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:parkspace/screens/authentication/signup_page.dart';
import 'package:parkspace/screens/home/home_main.dart';
import 'package:parkspace/screens/manager/manager_home.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/auth_title.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/booking_provider.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/login_page";
  LoginPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Press back button again to close the app."),),
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              const AuthTitle("Login"),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Column(
                  children: [
                    CTextField(
                      controller: usernameController,
                      hint: "Username",
                    ),
                    CTextField(
                      controller: passwordController,
                      hint: "Password",
                    ),
                  ],
                ),
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
              Consumer<AuthProvider>(builder: (context, provider, child) {
                return CButton(
                  isLoading: provider.loggingIn,
                  isDisabled: provider.loggingIn,
                  title: "Login",
                  onTap: () async {
                    if (usernameController.text == '' || passwordController.text == '') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "Oops",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kPrimaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          content: Text(
                            "Please fill all fields",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kSecondaryColor,
                              fontSize: 10.sp,
                            ),
                          ),
                          actions: [
                            FlatButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      await provider.login(
                        email: usernameController.text,
                        password: passwordController.text,
                        onSuccess: (val) async {
                          await context.read<UserProvider>().fetchUser(
                                userId: val,
                                onSuccess: (val) async {
                                  if (val.type == "CUSTOMER") {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      HomePage.routeName,
                                      ((route) => false),
                                    );
                                  } else {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      ManagerHome.routeName,
                                      ((route) => false),
                                    );
                                  }
                                },
                                onError: (val) {
                                  Globals.showCustomDialog(context: context, title: "Error", content: val);
                                  log(val);
                                },
                              );
                        },
                        onError: (val) {
                          Globals.showCustomDialog(context: context, title: "Error", content: val);
                          log(val);
                        },
                      );
                    }
                  },
                );
              })
            ],
          ),
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
              style: TextStyle(fontFamily: "Poppins", fontSize: 8.sp, color: kPrimaryColor, fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: "Click here ",
              style: TextStyle(fontFamily: "Poppins", fontSize: 8.sp, color: kSecondaryColor, fontWeight: FontWeight.w400, decoration: TextDecoration.underline),
            ),
            TextSpan(
              text: "to Signup now. ",
              style: TextStyle(fontFamily: "Poppins", fontSize: 8.sp, color: kPrimaryColor, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
