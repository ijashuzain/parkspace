import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class AreaData extends StatelessWidget {
  final bool isLeftAligned;
  final bool isCenterAligned;
  final String title;
  final String value;
  final double width;
  final VoidCallback? onTap;
  const AreaData({
    Key? key,
    this.isLeftAligned = true,
    required this.title,
    required this.value,
    required this.width,
    this.isCenterAligned = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: GestureDetector(
        onTap: () {
          onTap!();
        },
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: isLeftAligned
                ? CrossAxisAlignment.start
                : isCenterAligned
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 10.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 9.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
