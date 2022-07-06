import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/models/user_data.dart';
import 'package:parkspace/providers/auth_provider.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:parkspace/screens/manager/manager_home.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:provider/provider.dart';
import 'package:parkspace/screens/home/home_main.dart';
import 'package:parkspace/widgets/auth_title.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../../providers/booking_provider.dart';

class SignupPage extends StatefulWidget {
  static String routeName = "/signup_page";
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int userType = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              const AuthTitle("SignUp"),
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 7.w),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Text(
                          "Register As",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: kPrimaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: kPrimaryColor,
                            value: 0,
                            groupValue: userType,
                            onChanged: (int? val) {
                              userType = val!;
                              setState(() {});
                            },
                          ),
                          Text(
                            "Customer",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                            ),
                          ),
                          const Spacer(),
                          Radio(
                            value: 1,
                            activeColor: kPrimaryColor,
                            groupValue: userType,
                            onChanged: (int? val) {
                              userType = val!;
                              setState(() {});
                            },
                          ),
                          Text(
                            "Parking Agent",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Column(
                  children: [
                    CTextField(
                      controller: nameController,
                      hint: "Name",
                    ),
                    CTextField(
                      controller: emailController,
                      hint: "Email",
                    ),
                    CTextField(
                      controller: phoneController,
                      hint: "Phone",
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
              SizedBox(
                height: 1.h,
              ),
              Consumer<AuthProvider>(builder: (context, provider, child) {
                return CButton(
                  isDisabled: provider.signingUp,
                  isLoading: provider.signingUp,
                  title: "Signup",
                  onTap: () async {
                    if (nameController.text == '' ||
                        emailController.text == '' ||
                        phoneController.text == '' ||
                        passwordController.text == '') {
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
                      await provider.signup(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text,
                        user: UserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          type: userType == 0 ? "CUSTOMER" : "ADMIN",
                        ),
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
                                  log(val);
                                },
                              );
                        },
                        onError: (val) {
                          Globals.showCustomDialog(
                              context: context,
                              title: "Something went wrong",
                              content: val);
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
