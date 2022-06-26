import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:parkspace/screens/authentication/login_page.dart';
import 'package:parkspace/screens/home/home_main.dart';
import 'package:parkspace/screens/manager/manager_home.dart';
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
    _checkLogin(context);
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
                  } else {
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
