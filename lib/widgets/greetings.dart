import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class GreetingsWidget extends StatelessWidget {
  final String name;
  const GreetingsWidget(
    this.name, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              name,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontSize: 12.sp,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.person,color: kPrimaryColor,),
          )
        ],
      ),
    );
  }
}
