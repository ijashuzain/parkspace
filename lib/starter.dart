import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/models/user_data.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:parkspace/screens/authentication/login_page.dart';
import 'package:parkspace/screens/home/home_main.dart';
import 'package:parkspace/screens/manager/manager_home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class StarterPage extends StatefulWidget {
  static String routeName = "/starter";
  const StarterPage({Key? key}) : super(key: key);

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await requestPermission();
      await _checkLoggedIn(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 20.w,
              width: 20.w,
              child: Image.asset("assets/icons/logo.png"),
            ),
            Text(
              "ParkSpace",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontStyle: FontStyle.italic,
                fontFamily: "Poppins",
              ),
            ),
            const Spacer(),
            const CupertinoActivityIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      log("Permission granted");
    } else if (status.isDenied) {
      requestPermission();
    }
  }

  _checkLoggedIn(BuildContext context) async {
    UserProvider provider = context.read<UserProvider>();
    bool res = await provider.checkLoggedIn();
    if (res) {
      UserData? user = provider.currentUser;
      if (user != null) {
        if (user.type == "CUSTOMER") {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ManagerHome()), (route) => false);
        }
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
    }
  }

  _checkLogin(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) async {
        if (user == null) {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        } else {
          await context.read<UserProvider>().fetchUser(
                userId: user.uid,
                onSuccess: (user) async {
                  if (user.type == "CUSTOMER") {
                    Navigator.pushReplacementNamed(
                      context,
                      HomePage.routeName,
                    );
                  } else if (user.type == "ADMIN") {
                    Navigator.pushReplacementNamed(
                      context,
                      ManagerHome.routeName,
                    );
                  }
                },
                onError: (val) {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginPage.routeName,
                  );
                },
              );
        }
      },
    );
  }
}
