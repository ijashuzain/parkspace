import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  const AuthTitle(this.title,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SizedBox(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
              child: Image.asset("assets/icons/logo.png"),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }
}