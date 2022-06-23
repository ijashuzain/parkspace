import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/booking/new_booking.dart';
import 'package:parkspace/screens/booking/widgets/area_card_widget.dart';
import 'package:parkspace/screens/booking/widgets/area_slot_selector.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/booking_card.dart';
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
                  title: "CMS Parking Centre",
                  subtitle: "2876, St.Jose Dakota 2176",
                  color: Colors.red,
                  fromDate: "24 May, 2021",
                  toDate: "25 May, 2021",
                  fromTime: "12:00 AM",
                  toTime: "1:00 AM",
                  status: BookingStatus.confirmed,
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
