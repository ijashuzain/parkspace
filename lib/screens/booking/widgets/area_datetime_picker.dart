import 'package:flutter/material.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/colors.dart';
import 'area_data_widget.dart';

class AreaDateTimePicker extends StatelessWidget {
  final String? fromDate;
  final String? fromTime;
  final String? toTime;
  final Function onFromDateSelected;
  final Function onFromTimeSelected;
  final Function onToTimeSelected;
  const AreaDateTimePicker({
    Key? key,
    this.fromDate,
    this.fromTime,
    this.toTime,
    required this.onFromDateSelected,
    required this.onFromTimeSelected,
    required this.onToTimeSelected,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AreaData(
            title: "From Date",
            value: fromDate ?? 'Click to Select Date',
            width: 80.w,
            isLeftAligned: false,
            isCenterAligned: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                onFromDateSelected(Globals.formatDateTimeToString(picked));
              }
            },
          ),
          const Divider(color: kSecondaryColor),
          Row(
            children: [
              AreaData(
                title: "Parking Time",
                value: fromTime ?? 'Click to Select Time',
                width: 35.w,
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (picked != null) {
                    onFromTimeSelected(Globals.formatTimeOfDayToString(picked));
                  }
                },
              ),
              const VerticalDivider(color: kSecondaryColor),
              AreaData(
                title: "Pickup Time",
                value: toTime ?? 'Click to Select Time',
                width: 35.w,
                isLeftAligned: false,
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    onToTimeSelected(Globals.formatTimeOfDayToString(picked));
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
