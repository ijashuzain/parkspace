import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parkspace/utils/enumes.dart';
import 'package:provider/provider.dart';
import 'booking_provider.dart';

class HomeProvider extends ChangeNotifier {
  HomeNavigation homeNavigation = HomeNavigation.myBooking;
  HomeNavigation managerNavigation = HomeNavigation.managerBookings;

  void changeUserHomeNavigation({required BuildContext context, required HomeNavigation homeNavigation}) {
    this.homeNavigation = homeNavigation;
    notifyListeners();

    if(homeNavigation == HomeNavigation.myBooking){
      context.read<BookingProvider>().fetchAllMyBookings(
        context: context,
        onSuccess: (val) {
          log(val.toString());
        },
        onError: (val) {
          log(val.toString());
        },
      );
    }
  }

  void changeManagerHomeNavigation(HomeNavigation managerNav) {
    managerNavigation = managerNav;
    notifyListeners();
  }
}
