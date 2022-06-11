import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/authentication/login_page.dart';
import 'package:sizer/sizer.dart';

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

  void _checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushNamed(context, LoginPage.routeName);
  }
}
