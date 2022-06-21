import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/booking/widgets/area_card_widget.dart';
import 'package:parkspace/screens/booking/widgets/area_data_widget.dart';
import 'package:parkspace/screens/booking/widgets/area_slot_selector.dart';
import 'package:parkspace/screens/payment/payment_main.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/stack_card.dart';
import "package:sizer/sizer.dart";

class NewBooking extends StatelessWidget {
  const NewBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("Book New Build");
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 80.h,
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.only(left: 3.h, right: 3.h, bottom: 3.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    builder: (context) => StackCard(
                      title: "CMS Parking Centre",
                      onClose: () {
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 2.h),
                          const AreaDetailCard(
                            availableSlots: "20",
                            cameraStatus: true,
                            location:
                                "221b Baker St, London NW1 6XE, United Kingdom",
                            nightParking: false,
                            ratePerHour: "200",
                          ),
                          SizedBox(height: 2.h),
                          const SlotSelector(),
                          SizedBox(height: 2.h),
                          const AreaDateTimePicker(),
                          SizedBox(height: 2.h),
                          CButton(
                            title: "Pay",
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor: Colors.transparent,
                                builder: (context) => StackCard(
                                  child: const PaymentMain(),
                                  title: "Payment",
                                  onClose: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.pin_drop),
                    Text("Select Area From Map"),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AreaDateTimePicker extends StatelessWidget {
  const AreaDateTimePicker({
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AreaData(
            title: "From Date",
            value: "14-09-1998",
            width: 80.w,
            isLeftAligned: false,
            isCenterAligned: true,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
            },
          ),
          const Divider(color: kSecondaryColor),
          Row(
            children: [
              AreaData(
                title: "Parking Time",
                value: "7:00 AM",
                width: 35.w,
                onTap: () {
                  showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                },
              ),
              const VerticalDivider(color: kSecondaryColor),
              AreaData(
                title: "Pickup Time",
                value: "9:00 PM",
                width: 35.w,
                isLeftAligned: false,
                onTap: () {
                  showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
