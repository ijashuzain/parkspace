import 'package:flutter/material.dart';
import 'package:parkspace/utils/enumes.dart';

class HomeProvider extends ChangeNotifier {
  HomeNavigation homeNavigation = HomeNavigation.myBooking;

  void changeHomeNavigation(HomeNavigation homeNavigation) {
    this.homeNavigation = homeNavigation;
    notifyListeners();
  }
}
