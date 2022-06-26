import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class LineTabView extends StatefulWidget {

  final Function(int) onSelected;
  const LineTabView({Key? key, required this.onSelected}) : super(key: key);

  @override
  State<LineTabView> createState() => _LineTabViewState();
}

class _LineTabViewState extends State<LineTabView> {
  int selection = 0;

  @override
  void initState() {
    widget.onSelected(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selection = 0;
                  });
                  widget.onSelected(0);
                },
                child: SizedBox(
                  width: 20.w,
                  child: Text(
                    "Current",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: selection == 0 ? FontWeight.w600 : FontWeight.w500,
                      color: kPrimaryColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selection = 1;
                  });
                  widget.onSelected(1);
                },
                child: SizedBox(
                  width: 10.w,
                  child: Text(
                    "Past",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: selection == 1 ? FontWeight.w600 : FontWeight.w500,
                      color: kPrimaryColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              SizedBox(
                height: 1.h,
                child: const Divider(),
              ),
              SizedBox(
                height: 1.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 14.w,
                      height: 0.3.h,
                      color: selection == 0 ? kPrimaryColor : Colors.transparent,
                    ),
                    SizedBox(width: 6.w,),
                    Container(
                      width: 8.w,
                      height: 0.3.h,
                      color: selection == 1 ? kPrimaryColor : Colors.transparent,
                    ),
                    SizedBox(width: 7.w,),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
