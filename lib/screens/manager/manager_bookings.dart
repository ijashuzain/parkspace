import 'package:flutter/material.dart';
import 'package:parkspace/screens/booking/my_bookings.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/booking_card.dart';
import 'package:sizer/sizer.dart';

class ManagerBookings extends StatelessWidget {
  const ManagerBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
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
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
