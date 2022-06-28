import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parkspace/utils/enumes.dart';
import 'package:provider/provider.dart';
import 'booking_provider.dart';

class HomeProvider extends ChangeNotifier {
  HomeNavigation homeNavigation = HomeNavigation.myBooking;
  HomeNavigation managerNavigation = HomeNavigation.managerBookings;

  void changeUserHomeNavigation({required BuildContext context, required HomeNavigation homeNavigation}) async {
    this.homeNavigation = homeNavigation;
    notifyListeners();

    if (homeNavigation == HomeNavigation.myBooking) {
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
      notifyListeners();
    }
  }

  void changeManagerHomeNavigation({
    required BuildContext context,
    required HomeNavigation managerNav,
  }) async {
    managerNavigation = managerNav;
    notifyListeners();

    if (managerNav == HomeNavigation.managerBookings) {
      await context.read<BookingProvider>().checkForCompletion(context);
      context.read<BookingProvider>().fetchAllManagerBookings(
            context: context,
            onSuccess: (val) {
              log("Manager Booking Fetched");
            },
            onError: (val) {
              log(val.toString());
            },
          );
    }
  }
}
