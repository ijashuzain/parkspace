import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:parkspace/screens/profile/profile_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class GreetingsWidget extends StatelessWidget {
  final String name;
  final bool isProfile;
  const GreetingsWidget(
    this.name, {
    Key? key,
    this.isProfile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider,child) {
        return SizedBox(
          width: 100.w,
          height: 6.h,
          child: Stack(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor,
                  fontSize: 10.sp,
                ),
              ),
              Positioned(
                top: 2.h,
                child: Text(
                  provider.currentUser!.name,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              if (!isProfile)
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileMain(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                  ),
                )
            ],
          ),
        );
      }
    );
  }
}
