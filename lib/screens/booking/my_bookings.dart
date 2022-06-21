import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/booking/new_booking.dart';
import 'package:parkspace/screens/booking/widgets/area_card_widget.dart';
import 'package:parkspace/screens/booking/widgets/area_slot_selector.dart';
import 'package:parkspace/widgets/line_tab.dart';
import 'package:parkspace/widgets/stack_card.dart';
import 'package:sizer/sizer.dart';

class HomeBookings extends StatelessWidget {
  const HomeBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        children: [
          const LineTabView(),
          SizedBox(
            height: 69.h,
            width: 100.h,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return BookingCard(
                  name: "CMS Parking Centre",
                  address: "2876, St.Jose Dakota 2176",
                  color: Colors.red,
                  fromDate: "24 May, 2021",
                  toDate: "25 May, 2021",
                  fromTime: "12:00 AM",
                  toTime: "1:00 AM",
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      builder: (context) => StackCard(
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),
                            const AreaDetailCard(
                              availableSlots: "20",
                              cameraStatus: true,
                              location: "2876, St. Jose Dakota 2176",
                              nightParking: false,
                              ratePerHour: "100",
                            ),
                            SizedBox(height: 2.h),
                            const SlotSelector(),
                            SizedBox(height: 2.h),
                            const AreaDateTimePicker(),
                            SizedBox(height: 2.h),
                          ],
                        ),
                        title: "CMS Parking Centre",
                        onClose: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String name;
  final String address;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final Color color;
  final VoidCallback onTap;
  const BookingCard({
    Key? key,
    required this.name,
    required this.address,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          width: 100.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.h),
              border: Border.all(color: kSecondaryColor)),
          child: Row(
            children: [
              Container(
                height: 6.h,
                width: 0.5.w,
                color: color,
              ),
              Padding(
                padding: EdgeInsets.all(3.w),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: kPrimaryColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 9.sp,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          SizedBox(
                            width: 25.w,
                            child: Text(
                              fromDate,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: kPrimaryColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            Icons.arrow_forward,
                            size: 12.sp,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            toDate,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kPrimaryColor,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25.w,
                            child: Text(
                              fromTime,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 10.sp,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            Icons.arrow_forward,
                            size: 12.sp,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            toTime,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 9.sp,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
