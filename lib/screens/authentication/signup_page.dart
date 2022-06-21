import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/authentication/login_page.dart';
import 'package:parkspace/screens/home/home_main.dart';
import 'package:parkspace/widgets/auth_title.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class SignupPage extends StatelessWidget {
  static String routeName = "/signup_page";
  SignupPage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
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
                          value: 1,
                          groupValue: 1,
                          onChanged: (val) {},
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
                        Spacer(),
                        Radio(
                          value: 2,
                          activeColor: kPrimaryColor,
                          groupValue: 1,
                          onChanged: (val) {},
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
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 1.h,
            ),
            CButton(
              title: "Signup",
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
