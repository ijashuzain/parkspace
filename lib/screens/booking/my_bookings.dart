import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/models/booking_model.dart';
import 'package:parkspace/providers/booking_provider.dart';
import 'package:parkspace/screens/booking/new_booking.dart';
import 'package:parkspace/screens/booking/widgets/area_card_widget.dart';
import 'package:parkspace/screens/booking/widgets/area_datetime_picker.dart';
import 'package:parkspace/screens/booking/widgets/area_slot_selector.dart';
import 'package:parkspace/screens/booking/widgets/booking_widget.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/booking_card.dart';
import 'package:parkspace/widgets/line_tab.dart';
import 'package:parkspace/widgets/stack_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeBookings extends StatefulWidget {
  const HomeBookings({Key? key}) : super(key: key);

  @override
  State<HomeBookings> createState() => _HomeBookingsState();
}

class _HomeBookingsState extends State<HomeBookings> {
  List<Booking> bookingList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, provider, child) {
      if (provider.fetchingMyBookings) {
        return SizedBox(
          height: 69.h,
          width: 100.h,
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      }

      if (provider.allMyBookings.isEmpty) {
        return SizedBox(
          height: 69.h,
          width: 100.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No bookings found. Try to refresh"),
                IconButton(
                  onPressed: () {
                    provider.fetchAllMyBookings(context: context, onSuccess: (val) {}, onError: (val) {});
                  },
                  icon: const Icon(Icons.refresh),
                )
              ],
            ),
          ),
        );
      }

      return SizedBox(
        width: 100.w,
        child: Column(
          children: [
            LineTabView(
              onSelected: (val) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
                  if (val == 0) {
                    bookingList = provider.currentBookings;
                  } else {
                    bookingList = provider.pastBookings;
                  }
                  setState(() {});
                });
              },
            ),
            SizedBox(
              height: 69.h,
              width: 100.h,
              child: ListView.builder(
                itemCount: bookingList.length,
                itemBuilder: (context, index) {
                  return BookingCard(
                    title: bookingList[index].area!.areaName,
                    subtitle: bookingList[index].area!.areaAddress,
                    color: Colors.red,
                    fromDate: bookingList[index].fromDate,
                    toDate: bookingList[index].fromDate,
                    fromTime: bookingList[index].fromTime,
                    toTime: bookingList[index].toTime,
                    status: bookingList[index].status,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.transparent,
                        builder: (context) => StackCard(
                          child: BookingWidget(
                            area: bookingList[index].area!,
                            isEdit: true,
                            booking: bookingList[index],
                          ),
                          title: bookingList[index].area!.areaName,
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
    });
  }
}
