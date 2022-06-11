import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class MainTabView extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final Function onSelected;
  const MainTabView(
      {Key? key,
      required this.onSelected,
      required this.firstOption,
      required this.secondOption})
      : super(key: key);

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selection = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selection = 0;
              });
              widget.onSelected(selection);
            },
            child: Text(
              widget.firstOption,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: selection == 0 ? kPrimaryColor : kSecondaryColor,
                fontSize: selection == 0 ? 22.sp : 14.sp,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                selection = 1;
              });
              widget.onSelected(selection);
            },
            child: Text(
              widget.secondOption,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: selection != 1 ? kSecondaryColor : kPrimaryColor,
                fontSize: selection != 1 ? 14.sp : 22.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
