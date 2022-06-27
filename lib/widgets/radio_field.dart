import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CRadioField extends StatefulWidget {
  final String title;
  final Function(bool) onSelected;
  final bool value;

  const CRadioField({
    Key? key,
    required this.title,
    required this.onSelected,
    required this.value,
  }) : super(key: key);

  @override
  State<CRadioField> createState() => _CRadioFieldState();
}

class _CRadioFieldState extends State<CRadioField> {
  int selected = 0;

  @override
  void initState() {
    if (selected == 0) {
      widget.onSelected(widget.value);
    } else {
      widget.onSelected(widget.value);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              color: kPrimaryColor,
              fontSize: 10.sp,
            ),
          ),
          Row(
            children: [
              Radio(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 0,
                groupValue: selected,
                onChanged: (val) {
                  setState(() {
                    selected = int.parse(val.toString());
                  });
                  widget.onSelected(true);
                },
                activeColor: kPrimaryColor,
              ),
              SizedBox(width: 1.w),
              Text(
                "Available",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                  fontSize: 9.sp,
                ),
              ),
              Spacer(),
              Radio(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 1,
                groupValue: selected,
                onChanged: (val) {
                  setState(() {
                    selected = int.parse(val.toString());
                  });
                  widget.onSelected(false);
                },
                activeColor: kPrimaryColor,
              ),
              SizedBox(width: 1.w),
              Text(
                "Not Available",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
