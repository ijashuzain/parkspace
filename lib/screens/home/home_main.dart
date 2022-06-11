import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/home/home_bookings.dart';
import 'package:parkspace/widgets/line_tab.dart';
import 'package:parkspace/widgets/main_tab.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        height: 100.h,
        width: 100.h,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(3.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  const GreetingsWidget("Ijas Huzain"),
                  SizedBox(
                    height: 3.h,
                  ),
                  MainTabView(
                    firstOption: "My Bookings",
                    secondOption: "Book New",
                    onSelected: (val) {
                      if (val == 1) {}
                    },
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const HomeBookings()
                ],
              ),
            ),
            Container(
              height: 70.h,
              width: 100.h,
              color: kBackgroundColor,
            )
          ],
        ),
      ),
    );
  }
}

class GreetingsWidget extends StatelessWidget {
  final String name;
  const GreetingsWidget(
    this.name, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
              fontSize: 12.sp,
            ),
          ),
          Text(
            "Ijas Huzain",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              fontSize: 14.sp,
            ),
          )
        ],
      ),
    );
  }
}
