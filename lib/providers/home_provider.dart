import 'package:flutter/material.dart';
import 'package:parkspace/utils/enumes.dart';

class HomeProvider extends ChangeNotifier {
  HomeNavigation homeNavigation = HomeNavigation.myBooking;
  HomeNavigation managerNavigation = HomeNavigation.managerBookings;

  void changeUserHomeNavigation(HomeNavigation homeNavigation) {
    this.homeNavigation = homeNavigation;
    notifyListeners();
  }

  void changeManagerHomeNavigation(HomeNavigation managerNav) {
    managerNavigation = managerNav;
    notifyListeners();
  }
}
