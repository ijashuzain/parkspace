import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/home_provider.dart';
import 'package:parkspace/screens/manager/manager_areas.dart';
import 'package:parkspace/screens/manager/manager_bookings.dart';
import 'package:parkspace/utils/enumes.dart';
import 'package:parkspace/widgets/greetings.dart';
import 'package:parkspace/widgets/main_tab.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class ManagerHome extends StatelessWidget {
  static String routeName = "/manager_page";
  const ManagerHome({Key? key}) : super(key: key);

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
                        isManager: true,
                        firstOption: "Bookings",
                        secondOption: "My Areas",
                        onSelected: (val) {
                          provider.changeManagerHomeNavigation(context: context, managerNav: val);
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      provider.managerNavigation == HomeNavigation.managerBookings ? const ManagerBookings() : const ManagerAreas()
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
