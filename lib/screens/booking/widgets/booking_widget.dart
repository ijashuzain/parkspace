import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkspace/models/area_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../models/booking_model.dart';
import '../../../providers/booking_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/globals.dart';
import '../../../widgets/button.dart';
import '../../../widgets/stack_card.dart';
import '../../payment/payment_main.dart';
import 'area_card_widget.dart';
import 'area_datetime_picker.dart';
import 'area_slot_selector.dart';

class BookingWidget extends StatefulWidget {
  final Area area;
  final Booking? booking;
  final bool isEdit;
  BookingWidget({
    Key? key,
    required this.area,
    this.booking,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  String? fromDate;
  String? fromTime;
  String? toTime;

  int? selectedSlots;

  @override
  void initState() {
    selectedSlots = 1;
    if (widget.isEdit) {
      selectedSlots = widget.booking!.slots;
      fromDate = widget.booking!.fromDate;
      fromTime = widget.booking!.fromTime;
      toTime = widget.booking!.toTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h),
        AreaDetailCard(
          availableSlots: widget.area.slots.toString(),
          cameraStatus: widget.area.cameraStatus,
          location: widget.area.areaAddress,
          nightParking: widget.area.nightParking,
          ratePerHour: widget.area.rate.toString(),
        ),
        SizedBox(height: 2.h),
        SlotSelector(
          selectedSlotValue: selectedSlots!,
          totalSlots: widget.area.slots,
          onSelected: (val) {
            setState(() {
              selectedSlots = val;
            });
          },
        ),
        SizedBox(height: 2.h),
        AreaDateTimePicker(
          fromDate: fromDate,
          fromTime: fromTime,
          toTime: toTime,
          onFromDateSelected: (val) {
            log(val.toString());
            setState(() {
              fromDate = val;
            });
          },
          onFromTimeSelected: (val) {
            log(val.toString());
            setState(() {
              fromTime = val;
            });
          },
          onToTimeSelected: (val) {
            log(val.toString());
            setState(() {
              toTime = val;
            });
          },
        ),
        SizedBox(height: 2.h),
        Consumer<BookingProvider>(builder: (context, provider, child) {
          return widget.isEdit
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CButton(
                      isDisabled: provider.updatingBooking,
                      isLoading: provider.updatingBooking,
                      title: "Update",
                      onTap: () {
                        provider.updateBooking(
                          booking: Booking(
                              status: BookingStatus.pending,
                              fromDate: fromDate!,
                              fromTime: fromTime!,
                              toTime: toTime!,
                              areaId: widget.booking!.area!.id!,
                              uid: widget.booking!.uid,
                              slots: selectedSlots!,
                              id: widget.booking!.id),
                          onSuccess: (val) {
                            Navigator.pop(context);
                            provider.fetchAllMyBookings(
                              context: context,
                              onError: (val) {},
                              onSuccess: (val) {},
                            );
                            Globals.showCustomDialog(context: context, title: "Success", content: "Booking updated success");
                          },
                          onError: (val) {
                            Navigator.pop(context);
                            provider.fetchAllMyBookings(
                              context: context,
                              onError: (val) {},
                              onSuccess: (val) {},
                            );
                            Globals.showCustomDialog(context: context, title: "Error", content: "Something went wrong");
                          },
                        );
                      },
                    ),
                    CButton(
                      isDisabled: provider.updatingBooking,
                      isLoading: provider.updatingBooking,
                      title: "Delete",
                      onTap: () {
                        provider.deleteBooking(
                          bookingId: widget.booking!.id!,
                          onSuccess: (val) {
                            Navigator.pop(context);
                            Globals.showCustomDialog(context: context, title: "Success", content: "Booking deleted success");
                          },
                          onError: (val) {
                            Navigator.pop(context);
                            Globals.showCustomDialog(context: context, title: "Error", content: "Something went wrong");
                          },
                        );
                      },
                    ),
                  ],
                )
              : CButton(
                  isLoading: provider.creatingBooking,
                  isDisabled: provider.creatingBooking,
                  title: "Book",
                  onTap: () async {
                    var userProvider = context.read<UserProvider>();
                    var userId = userProvider.currentUser!.id;
                    await provider.createBooking(
                      booking: Booking(
                        slots: selectedSlots!,
                        uid: userId!,
                        status: BookingStatus.pending,
                        toTime: toTime!,
                        fromTime: fromTime!,
                        fromDate: fromDate!,
                        areaId: widget.area.id!,
                      ),
                      onSuccess: (val) {
                        Navigator.pop(context);
                        Globals.showCustomDialog(
                          context: context,
                          title: "Success",
                          content: val,
                        );
                      },
                      onError: (val) {
                        Navigator.pop(context);
                        Globals.showCustomDialog(
                          context: context,
                          title: "Something went wrong",
                          content: val,
                        );
                      },
                    );
                    // showModalBottomSheet(
                    //   context: context,
                    //   isScrollControlled: true,
                    //   backgroundColor: Colors.transparent,
                    //   barrierColor: Colors.transparent,
                    //   builder: (context) => StackCard(
                    //     child: const PaymentMain(),
                    //     title: "Payment",
                    //     onClose: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // );
                  },
                );
        })
      ],
    );
  }
}
