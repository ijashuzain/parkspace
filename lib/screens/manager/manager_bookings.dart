import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/providers/booking_provider.dart';
import 'package:parkspace/screens/booking/my_bookings.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/booking_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ManagerBookings extends StatefulWidget {
  const ManagerBookings({Key? key}) : super(key: key);

  @override
  State<ManagerBookings> createState() => _ManagerBookingsState();
}

class _ManagerBookingsState extends State<ManagerBookings> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read<BookingProvider>().fetchAllManagerBookings(
            context: context,
            onSuccess: (val) {
              log("Manager Booking Fetched");
            },
            onError: (val) {
              log(val.toString());
            },
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<BookingProvider>(builder: (context, provider, child) {
        if (provider.fetchingManagerBookings) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (provider.allManagerBookings.isEmpty) {
          return const Center(
            child: Text("No Bookings Found"),
          );
        }

        return SizedBox(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: provider.allManagerBookings.length,
            itemBuilder: (context, index) {
              return BookingCard(

                title: provider.allMyBookings[index].user!.name,
                subtitle: provider.allMyBookings[index].area!.areaName,
                color: Colors.red,
                fromDate: provider.allMyBookings[index].fromDate,
                toDate: provider.allMyBookings[index].fromDate,
                fromTime: provider.allMyBookings[index].fromTime,
                toTime: provider.allMyBookings[index].toTime,
                status: provider.allMyBookings[index].status,
                onTap: () {},
              );
            },
          ),
        );
      }),
    );
  }
}
