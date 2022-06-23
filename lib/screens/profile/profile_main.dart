import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/greetings.dart';
import 'package:parkspace/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class ProfileMain extends StatelessWidget {
  ProfileMain({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                  width: 100.w,
                  child: Stack(
                    children: [
                      const GreetingsWidget(
                        "Administrator",
                        isProfile: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 6.w,
                            width: 6.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: kSecondaryColor,
                              ),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 4.w,
                            ),
                          ),
                        ),
                      )
                    ],
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
                  controller: placeController,
                  hint: "Place",
                ),
                SizedBox(height: 2.h),
                CButton(
                  title: "Update",
                  onTap: () {},
                ),
                SizedBox(height: 6.h),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 5.h,
                    child: Row(
                      children: [
                        Text(
                          "Signout",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
