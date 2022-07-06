import 'dart:developer';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/home_provider.dart';
import 'package:parkspace/screens/booking/my_bookings.dart';
import 'package:parkspace/screens/booking/new_booking.dart';
import 'package:parkspace/utils/enumes.dart';
import 'package:parkspace/widgets/greetings.dart';
import 'package:parkspace/widgets/line_tab.dart';
import 'package:parkspace/widgets/main_tab.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/booking_provider.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read<BookingProvider>().checkForCompletion(context);
      context.read<BookingProvider>().fetchAllMyBookings(
            context: context,
            onSuccess: (val) {
              log(val.toString());
            },
            onError: (val) {
              log(val.toString());
            },
          );
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text("Press back button again to close the app."),
        ),
        child: Consumer<HomeProvider>(builder: (context, provider, child) {
          return SizedBox(
            height: 100.h,
            width: 100.w,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(3.h),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
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
                            provider.changeUserHomeNavigation(
                                context: context, homeNavigation: val);
                          },
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        provider.homeNavigation == HomeNavigation.myBooking
                            ? HomeBookings()
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
                if (provider.homeNavigation == HomeNavigation.newBooking)
                  NewBooking()
              ],
            ),
          );
        }),
      ),
    );
  }
}
