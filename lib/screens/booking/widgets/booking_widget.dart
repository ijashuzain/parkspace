import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkspace/models/area_model.dart';
import 'package:parkspace/providers/area_provider.dart';
import 'package:parkspace/screens/payment/payment_main.dart';
import 'package:parkspace/widgets/stack_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../models/booking_model.dart';
import '../../../providers/booking_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/globals.dart';
import '../../../utils/statuses.dart';
import '../../../widgets/button.dart';
import 'area_card_widget.dart';
import 'area_datetime_picker.dart';
import 'area_slot_selector.dart';

class BookingWidget extends StatefulWidget {
  final Area area;
  final Booking? booking;
  final bool isEdit;
  final bool isManage;
  BookingWidget({
    Key? key,
    required this.area,
    this.booking,
    this.isEdit = false,
    this.isManage = false,
  }) : super(key: key);

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  String? fromDate;
  String? fromTime;
  String? toTime;
  bool locked = false;
  int? selectedSlots;
  int slotCount = 0;
  List<DropdownMenuItem<int>> slotsMenu = [];

  @override
  void initState() {
    selectedSlots = 1;
    if (widget.isEdit || widget.isManage) {
      selectedSlots = widget.booking!.slots;
      fromDate = widget.booking!.fromDate;
      fromTime = widget.booking!.fromTime;
      toTime = widget.booking!.toTime;
    }

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      int slots =
          await context.read<AreaProvider>().getBookedSlots(widget.area.id!);
      slotCount = slots;
      if (slotCount >= widget.area.slots) {
        locked = true;
      }
      slotsMenu = _generateSlotsMenu(widget.area.slots - slotCount);
      setState(() {});
    });

    super.initState();
  }

  List<DropdownMenuItem<int>> _generateSlotsMenu(int totalSlots) {
    List<DropdownMenuItem<int>> menusList = [];
    for (var i = 1; i <= totalSlots; i++) {
      menusList.add(DropdownMenuItem(
        child: Text(i.toString()),
        value: i,
      ));
    }
    return menusList;
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
          menuList: slotsMenu,
          locked: locked,
          selectedSlotValue: selectedSlots!,
          totalSlots: widget.area.slots - slotCount,
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
          if (widget.isEdit) {
            if(widget.booking!.status == BookingStatus.confirmed || widget.booking!.status == BookingStatus.completed){
              return _deleteControls(provider);
            }else{
              return _editControls(provider);
            }
          } else {
            if (widget.isManage) {
              if (widget.booking!.status == BookingStatus.pending) {
                return _managementControls(provider);
              } else if (widget.booking!.status == BookingStatus.confirmed) {
                return _deleteAndCompleteControls(provider);
              } else {
                return _deleteControls(provider);
              }
            } else {
              return _bookingControls(provider);
            }
          }
        })
      ],
    );
  }

  _deleteAndCompleteControls(BookingProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CButton(
          isDisabled: provider.updatingBooking,
          isLoading: provider.updatingBooking,
          title: "Complete",
          onTap: () {
            provider.updateBookingStatus(
              context: context,
              booking: widget.booking!,
              bookingStatus: BookingStatus.completed,
              onSuccess: (val) {
                Navigator.pop(context);
                provider.fetchAllManagerBookings(
                  context: context,
                  onError: (val) {},
                  onSuccess: (val) {},
                );
                Globals.showCustomDialog(
                  context: context,
                  title: "Success",
                  content: "Booking updating has been successfully completed",
                );
              },
              onError: (val) {
                Navigator.pop(context);
                provider.fetchAllMyBookings(
                  context: context,
                  onError: (val) {},
                  onSuccess: (val) {},
                );
                Globals.showCustomDialog(
                  context: context,
                  title: "Error",
                  content: "Something went wrong",
                );
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
                provider.fetchAllManagerBookings(
                  context: context,
                  onError: (val) {},
                  onSuccess: (val) {},
                );
                Globals.showCustomDialog(
                  context: context,
                  title: "Success",
                  content: "Booking deleted success",
                );
              },
              onError: (val) {
                Navigator.pop(context);
                Globals.showCustomDialog(
                  context: context,
                  title: "Error",
                  content: "Something went wrong",
                );
              },
            );
          },
        ),
      ],
    );
  }

  _bookingControls(BookingProvider provider) {
    return CButton(
      isLoading: provider.creatingBooking,
      isDisabled: provider.creatingBooking,
      title: "Book",
      onTap: () async {
        if (locked) {
          Globals.showCustomDialog(
            context: context,
            title: "Something went wrong",
            content: "There are no slots left",
          );
        } else {
          if (fromTime != null || toTime != null || fromDate != null) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              builder: (context) => StackCard(
                title: "Payment",
                onClose: () {
                  Navigator.pop(context);
                },
                child: PaymentMain(
                  amount: 1000,
                  product: widget.area.areaName,
                  onSuccess: () async {
                    Navigator.pop(context);
                    _createBooking(provider);
                  },
                  onError: () {
                    Globals.showCustomDialog(
                      context: context,
                      title: "Payment Failed",
                      content: "Something went wrong while paying",
                    );
                  },
                ),
              ),
            );
          } else {
            Globals.showCustomDialog(
              context: context,
              title: "Oops",
              content: "Please select date and time",
            );
          }
        }
      },
    );
  }

  _createBooking(BookingProvider provider) async {
    var userProvider = context.read<UserProvider>();
    var userId = userProvider.currentUser!.id;
    await provider.createBooking(
      booking: Booking(
        slots: selectedSlots!,
        uid: userId!,
        status: BookingStatus.confirmed,
        toTime: toTime!,
        fromTime: fromTime!,
        fromDate: fromDate!,
        areaId: widget.area.id!,
      ),
      onSuccess: (val) {
        print('Booking Success');
        Navigator.pop(context);
        context.read<BookingProvider>().fetchAllMyBookings(
              context: context,
              onSuccess: (val),
              onError: (val),
            );
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
  }

  _managementControls(BookingProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CButton(
          isDisabled: provider.updatingBooking,
          isLoading: provider.updatingBooking,
          title: "Accept",
          onTap: () {
            if (locked) {
              Globals.showCustomDialog(
                context: context,
                title: "Something went wrong",
                content: "There are no slots left",
              );
            } else {
              provider.updateBookingStatus(
                context: context,
                booking: widget.booking!,
                bookingStatus: BookingStatus.confirmed,
                onSuccess: (val) {
                  Navigator.pop(context);
                  provider.fetchAllManagerBookings(
                    context: context,
                    onError: (val) {},
                    onSuccess: (val) {},
                  );
                  Globals.showCustomDialog(
                    context: context,
                    title: "Success",
                    content: "Booking updating has been successfully completed",
                  );
                },
                onError: (val) {
                  Navigator.pop(context);
                  provider.fetchAllMyBookings(
                    context: context,
                    onError: (val) {},
                    onSuccess: (val) {},
                  );
                  Globals.showCustomDialog(
                    context: context,
                    title: "Error",
                    content: "Something went wrong",
                  );
                },
              );
            }
          },
        ),
        CButton(
          isDisabled: provider.updatingBooking,
          isLoading: provider.updatingBooking,
          title: "Reject",
          onTap: () {
            provider.updateBookingStatus(
              context: context,
              booking: widget.booking!,
              bookingStatus: BookingStatus.rejected,
              onSuccess: (val) {
                Navigator.pop(context);
                provider.fetchAllManagerBookings(
                  context: context,
                  onError: (val) {},
                  onSuccess: (val) {},
                );
                Globals.showCustomDialog(
                  context: context,
                  title: "Rejected",
                  content: "Booking rejection has been successfully completed",
                );
              },
              onError: (val) {
                Navigator.pop(context);
                Globals.showCustomDialog(
                  context: context,
                  title: "Error",
                  content: "Something went wrong",
                );
              },
            );
          },
        ),
      ],
    );
  }

  _deleteControls(BookingProvider provider) {
    return CButton(
      isDisabled: provider.updatingBooking,
      isLoading: provider.updatingBooking,
      title: "Delete",
      onTap: () {
        provider.deleteBooking(
          bookingId: widget.booking!.id!,
          onSuccess: (val) {
            Navigator.pop(context);
            provider.fetchAllManagerBookings(
              context: context,
              onError: (val) {},
              onSuccess: (val) {},
            );
            Globals.showCustomDialog(
              context: context,
              title: "Success",
              content: "Booking deleted success",
            );
          },
          onError: (val) {
            Navigator.pop(context);
            Globals.showCustomDialog(
              context: context,
              title: "Error",
              content: "Something went wrong",
            );
          },
        );
      },
    );
  }

  _editControls(BookingProvider provider) {
    return Row(
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
                id: widget.booking!.id,
              ),
              onSuccess: (val) {
                Navigator.pop(context);
                provider.fetchAllMyBookings(
                  context: context,
                  onError: (val) {},
                  onSuccess: (val) {},
                );
                Globals.showCustomDialog(
                  context: context,
                  title: "Success",
                  content: "Booking updated success",
                );
              },
              onError: (val) {
                Navigator.pop(context);
                provider.fetchAllMyBookings(
                  context: context,
                  onError: (val) {},
                  onSuccess: (val) {},
                );
                Globals.showCustomDialog(
                  context: context,
                  title: "Error",
                  content: "Something went wrong",
                );
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
                provider.fetchAllMyBookings(
                  context: context,
                  onError: (val) {},
                  onSuccess: (val) {},
                );
                Globals.showCustomDialog(
                  context: context,
                  title: "Success",
                  content: "Booking deleted success",
                );
              },
              onError: (val) {
                Navigator.pop(context);
                Globals.showCustomDialog(
                  context: context,
                  title: "Error",
                  content: "Something went wrong",
                );
              },
            );
          },
        ),
      ],
    );
  }
}
