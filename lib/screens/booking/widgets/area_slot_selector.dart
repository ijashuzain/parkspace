import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class SlotSelector extends StatelessWidget {
  const SlotSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 1.h),
            Text(
              "Selected Slots",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 10.sp,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton(
              isExpanded: true,
              hint: const Text("Select Slots"),
              borderRadius: const BorderRadius.all(const Radius.circular(12)),
              underline: const SizedBox(),
              value: 1,
              items: const [
                DropdownMenuItem(
                  child: Text("1"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("2"),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text("3"),
                  value: 3,
                )
              ],
              onChanged: (val) {},
            )
          ],
        ),
      ),
    );
  }
}
