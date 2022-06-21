import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/home_provider.dart';
import 'package:parkspace/screens/booking/my_bookings.dart';
import 'package:parkspace/screens/booking/new_booking.dart';
import 'package:parkspace/utils/enumes.dart';
import 'package:parkspace/widgets/line_tab.dart';
import 'package:parkspace/widgets/main_tab.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Consumer<HomeProvider>(builder: (context, provider, child) {
        return SizedBox(
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
                    const GreetingsWidget("Administrator"),
                    MainTabView(
                      firstOption: "My Bookings",
                      secondOption: "Book New",
                      onSelected: (val) {
                        provider.changeHomeNavigation(val);
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    provider.homeNavigation == HomeNavigation.myBooking
                        ? const HomeBookings()
                        : const SizedBox()
                  ],
                ),
              ),
              if (provider.homeNavigation == HomeNavigation.newBooking)
                NewBooking()
            ],
          ),
        );
      }),
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
            name,
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
