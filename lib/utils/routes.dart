import 'package:flutter/material.dart';
import 'package:parkspace/screens/authentication/login_page.dart';
import 'package:parkspace/screens/authentication/signup_page.dart';
import 'package:parkspace/screens/home/home_main.dart';
import 'package:parkspace/starter.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (_) => const HomePage(),
  StarterPage.routeName: (_) => const StarterPage(),
  HomePage.routeName: (_) => const HomePage(),
  LoginPage.routeName: (_) =>  LoginPage(),
  SignupPage.routeName: (_) => const SignupPage()
};