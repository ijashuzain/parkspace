import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/home_provider.dart';
import 'package:parkspace/utils/enumes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MainTabView extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final Function onSelected;
  final bool isManager;
  const MainTabView({
    Key? key,
    required this.onSelected,
    required this.firstOption,
    required this.secondOption,
    this.isManager = false,
  }) : super(key: key);

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      bool firstOptionSelected = true;
      if (widget.isManager) {
        if (provider.managerNavigation == HomeNavigation.managerBookings) {
          firstOptionSelected = true;
        } else {
          firstOptionSelected = false;
        }
      } else {
        if (provider.homeNavigation == HomeNavigation.myBooking) {
          firstOptionSelected = true;
        } else {
          firstOptionSelected = false;
        }
      }

      log("First Option Selected : $firstOptionSelected");

      return SizedBox(
        width: 100.w,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (widget.isManager) {
                  widget.onSelected(HomeNavigation.managerBookings);
                } else {
                  widget.onSelected(HomeNavigation.myBooking);
                }
                setState(() {});
              },
              child: Text(
                widget.firstOption,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: firstOptionSelected ? kPrimaryColor : kSecondaryColor,
                  fontSize: firstOptionSelected ? 22.sp : 14.sp,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (widget.isManager) {
                  widget.onSelected(HomeNavigation.managerAreas);
                } else {
                  widget.onSelected(HomeNavigation.newBooking);
                }
                setState(() {});
              },
              child: Text(
                widget.secondOption,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: firstOptionSelected ? kSecondaryColor : kPrimaryColor,
                  fontSize: firstOptionSelected ? 14.sp : 22.sp,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
