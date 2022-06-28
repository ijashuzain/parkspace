import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class SlotSelector extends StatefulWidget {
  final int selectedSlotValue;
  final int totalSlots;
  final Function onSelected;
  final bool locked;
  final List<DropdownMenuItem<int>> menuList;
  const SlotSelector({
    Key? key,
    required this.selectedSlotValue,
    required this.totalSlots,
    required this.onSelected,
    required this.locked, required this.menuList,
  }) : super(key: key);

  @override
  State<SlotSelector> createState() => _SlotSelectorState();
}

class _SlotSelectorState extends State<SlotSelector> {
  @override
  void initState() {
    super.initState();
  }

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
            DropdownButton<int>(
              isExpanded: true,
              hint:  Text(widget.locked ? "There is no slots left" : "Select Slots"),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              underline: const SizedBox(),
              value: widget.locked ? null : widget.selectedSlotValue,
              items: widget.locked ? [] : widget.menuList,
              onChanged: (val) {
                widget.onSelected(int.parse(val.toString()));
              },
            )
          ],
        ),
      ),
    );
  }
}
