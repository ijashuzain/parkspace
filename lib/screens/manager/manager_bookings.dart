import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/providers/booking_provider.dart';
import 'package:parkspace/screens/booking/my_bookings.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/booking_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/stack_card.dart';
import '../booking/widgets/booking_widget.dart';

class ManagerBookings extends StatefulWidget {
  const ManagerBookings({Key? key}) : super(key: key);

  @override
  State<ManagerBookings> createState() => _ManagerBookingsState();
}

class _ManagerBookingsState extends State<ManagerBookings> {
  @override
  void initState() {
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("No bookings found. Try to refresh"),
                IconButton(
                  onPressed: () {
                    provider.fetchAllManagerBookings(
                      context: context,
                      onSuccess: (val) {},
                      onError: (val) {},
                    );
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
          );
        }

        return SizedBox(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: provider.allManagerBookings.length,
            itemBuilder: (context, index) {
              return BookingCard(
                title: provider.allManagerBookings[index].user!.name,
                subtitle: provider.allManagerBookings[index].area!.areaName,
                color: Colors.red,
                fromDate: provider.allManagerBookings[index].fromDate,
                toDate: provider.allManagerBookings[index].fromDate,
                fromTime: provider.allManagerBookings[index].fromTime,
                toTime: provider.allManagerBookings[index].toTime,
                status: provider.allManagerBookings[index].status,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    builder: (context) => StackCard(
                      child: BookingWidget(
                        area: provider.allManagerBookings[index].area!,
                        isManage: true,
                        booking: provider.allManagerBookings[index],
                      ),
                      title: provider.allManagerBookings[index].area!.areaName,
                      onClose: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
