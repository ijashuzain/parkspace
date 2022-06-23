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
              },
              child: Text(
                widget.firstOption,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: provider.homeNavigation == HomeNavigation.myBooking && provider.managerNavigation == HomeNavigation.managerBookings
                      ? kPrimaryColor
                      : kSecondaryColor,
                  fontSize: provider.homeNavigation == HomeNavigation.myBooking && provider.managerNavigation == HomeNavigation.managerBookings
                      ? 22.sp
                      : 14.sp,
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
              },
              child: Text(
                widget.secondOption,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: provider.homeNavigation != HomeNavigation.newBooking && provider.managerNavigation != HomeNavigation.managerAreas
                      ? kSecondaryColor
                      : kPrimaryColor,
                  fontSize: provider.homeNavigation != HomeNavigation.newBooking && provider.managerNavigation != HomeNavigation.managerAreas
                      ? 14.sp
                      : 22.sp,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
