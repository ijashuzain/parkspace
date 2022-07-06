import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final TextInputType type;
  const CTextField({
    Key? key,
    required this.controller,
    required this.hint, this.isPassword = false, this.type = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h,bottom: 1.5.h),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 10.sp
          ),
        ),
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
