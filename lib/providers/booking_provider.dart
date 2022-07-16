import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkspace/models/area_model.dart';
import 'package:parkspace/providers/area_provider.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:parkspace/models/user_data.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:parkspace/utils/statuses.dart';
import 'package:provider/provider.dart';
import '../models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Booking> currentBookings = [];
  List<Booking> pastBookings = [];
  List<Booking> allMyBookings = [];
  List<Booking> allManagerBookings = [];

  bool fetchingMyBookings = false;
  bool fetchingManagerBookings = false;
  bool creatingBooking = false;
  bool updatingBooking = false;

  createBooking({
    required Booking booking,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setCreatingBooking(true);
    try {
      var docRef = db.collection('bookings').doc();
      booking.id = docRef.id;
      await db.collection('bookings').doc(docRef.id).set(booking.toMap());
      _setCreatingBooking(false);
      onSuccess("Booking added successfully.");
    } catch (e) {
      _setCreatingBooking(false);
      onError("Booking error : ${e.toString()}");
    }
  }

  updateBookingStatus({
    required BuildContext context,
    required Booking booking,
    required String bookingStatus,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setUpdatingBooking(true);
    try {
      await db
          .collection('bookings')
          .doc(booking.id)
          .set({"status": bookingStatus}, SetOptions(merge: true));
      allMyBookings.clear();
      currentBookings.clear();
      pastBookings.clear();
      _setUpdatingBooking(false);
      onSuccess("Booking Updated successfully.");
    } catch (e) {
      _setUpdatingBooking(false);
      onError("Updating error : ${e.toString()}");
    }
  }

  updateBooking({
    required Booking booking,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setUpdatingBooking(true);
    try {
      var id = booking.id;
      await db
          .collection('bookings')
          .doc(id)
          .set(booking.toMap(), SetOptions(merge: true));
      allMyBookings.clear();
      currentBookings.clear();
      pastBookings.clear();
      _setUpdatingBooking(false);
      onSuccess("Booking Updated successfully.");
    } catch (e) {
      _setUpdatingBooking(false);
      onError("Updating error : ${e.toString()}");
    }
  }

  checkForCompletion(BuildContext context) async {
    var res = await db
        .collection('bookings')
        .where('status', isEqualTo: BookingStatus.confirmed)
        .get();
    for (var element in res.docs) {
      Booking booking = Booking.fromJson(element.data());
      bool isPassed = false;
      bool isDatePassed = _checkDatePassed(booking.fromDate);
      log("Is Date Passed : $isDatePassed");
      if (!isDatePassed) {
        bool isTimePassed = _checkTimePassed(booking.toTime);
        if (isTimePassed) {
          isPassed = true;
        }
      } else {
        isPassed = true;
      }
      if (isPassed) {
        await updateBookingStatus(
          context: context,
          booking: booking,
          bookingStatus: BookingStatus.completed,
          onSuccess: (val) {},
          onError: (val) {},
        );
      }
    }
  }

  deleteBooking({
    required String bookingId,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setUpdatingBooking(true);
    try {
      await db.collection('bookings').doc(bookingId).delete();
      allMyBookings.clear();
      currentBookings.clear();
      pastBookings.clear();
      _setUpdatingBooking(false);
      onSuccess("Booking Deleted successfully.");
    } catch (e) {
      _setUpdatingBooking(false);
      onError("Deleting error : ${e.toString()}");
    }
  }

  fetchAllMyBookings({
    required BuildContext context,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setMyBookingFetchingStatus(true);
    try {
      var userProvider = context.read<UserProvider>();
      var userId = userProvider.currentUser!.id;
      var bookingSnap =
          await db.collection('bookings').where('uid', isEqualTo: userId).get();
      if (bookingSnap.docs.isNotEmpty) {
        allMyBookings = [];
        if (allMyBookings.isEmpty) {
          log("All bookings : ${allMyBookings.length}");
          for (var element in bookingSnap.docs) {
            var area = await context
                .read<AreaProvider>()
                .fetchSingleArea(element.data()['areaId']);
            var usr = await context
                .read<UserProvider>()
                .fetchUserById(uid: element.data()['uid']);
            if (area != null) {
              Booking booking = Booking(
                slots: element.data()['slots'],
                area: area,
                user: usr,
                areaId: element.data()['areaId'],
                fromDate: element.data()['fromDate'],
                fromTime: element.data()['fromTime'],
                toTime: element.data()['toTime'],
                id: element.data()['id'],
                status: element.data()['status'],
                uid: element.data()['uid'],
              );
              allMyBookings.add(booking);
            }
          }
        }
        _categoriseBookings();
      } else {
        allMyBookings = [];
        notifyListeners();
      }
      _setMyBookingFetchingStatus(false);
      onSuccess("Success");
    } catch (e) {
      _setMyBookingFetchingStatus(false);
      onError(e);
    }
  }

  fetchAllManagerBookings({
    required BuildContext context,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setManagerBookingFetchingStatus(true);
    try {
      var userProvider = context.read<UserProvider>();
      var userId = userProvider.currentUser!.id;
      List<Area> managerAreas =
          await context.read<AreaProvider>().fetchAllMyAreas(context);
      if (managerAreas.isNotEmpty) {
        var bookingSnap = await db.collection('bookings').get();
        allManagerBookings = [];
        if (bookingSnap.docs.isNotEmpty) {
          for (var element in bookingSnap.docs) {
            for (var managerArea in managerAreas) {
              if (managerArea.id == element.data()['areaId']) {
                var area = await context
                    .read<AreaProvider>()
                    .fetchSingleArea(element.data()['areaId']);
                var usr = await context
                    .read<UserProvider>()
                    .fetchUserById(uid: element.data()['uid']);
                if (area != null) {
                  Booking booking = Booking(
                    slots: element.data()['slots'],
                    user: usr,
                    area: area,
                    areaId: element.data()['areaId'],
                    fromDate: element.data()['fromDate'],
                    fromTime: element.data()['fromTime'],
                    toTime: element.data()['toTime'],
                    id: element.data()['id'],
                    status: element.data()['status'],
                    uid: element.data()['uid'],
                  );

                  if (booking.status == BookingStatus.pending) {
                    bool isPassed = false;
                    bool isDatePassed =
                        _checkDatePassed(element.data()['fromDate']);
                    if (!isDatePassed) {
                      bool isTimePassed =
                          _checkTimePassed(element.data()['toTime']);
                      if (isTimePassed) {
                        isPassed = true;
                      }
                    } else {
                      isPassed = true;
                    }

                    if (isPassed) {
                      await deleteBooking(
                          bookingId: element.id,
                          onSuccess: (val) {},
                          onError: (val) {});
                    } else {
                      _addToManagerBookingList(booking);
                    }
                  } else {
                    _addToManagerBookingList(booking);
                  }
                }
              }
            }
          }
        }
      } else {
        allManagerBookings = [];
        notifyListeners();
      }
      _setManagerBookingFetchingStatus(false);
      onSuccess("Success");
    } catch (e) {
      _setManagerBookingFetchingStatus(false);
      onError(e);
    }
  }

  _addToManagerBookingList(Booking booking) {
    allManagerBookings.add(booking);
    notifyListeners();
  }

  bool _checkDatePassed(String dateString) {
    DateTime date = Globals.formatStringToDateTime(dateString);
    int difference = date.difference(DateTime.now()).inDays;
    if (difference < 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkTimePassed(String timeString) {
    TimeOfDay time = Globals.formatStringToTimeOfDay(timeString);
    double toDouble(time) => time.hour + time.minute/60.0;
    var differance = toDouble(time) - toDouble(TimeOfDay.now());
    log("Time Difference : " + differance.toString());
    if (differance < 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<Booking?> _getSingleBooking(String bookingId) async {
    var bookingDoc = await db.collection("bookings").doc(bookingId).get();
    if (bookingDoc.exists) {
      Booking booking = Booking.fromJson(bookingDoc.data()!);
      return booking;
    } else {
      return null;
    }
  }

  _categoriseBookings() {
    currentBookings = [];
    pastBookings = [];
    for (var element in allMyBookings) {
      if (element.status == BookingStatus.completed) {
        pastBookings.add(element);
      } else {
        currentBookings.add(element);
      }
    }
    notifyListeners();
  }

  _setMyBookingFetchingStatus(bool val) {
    fetchingMyBookings = val;
    notifyListeners();
  }

  _setCreatingBooking(bool val) {
    creatingBooking = val;
    notifyListeners();
  }

  _setUpdatingBooking(bool val) {
    updatingBooking = val;
    notifyListeners();
  }

  _setManagerBookingFetchingStatus(bool val) {
    fetchingManagerBookings = val;
    notifyListeners();
  }
}
