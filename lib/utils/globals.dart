import 'package:flutter/material.dart';
import 'package:parkspace/widgets/stack_card.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';

class Globals {
  static showStackSheet({
    required BuildContext context,
    required Widget child,
    required String title,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => StackCard(
        child: child,
        title: title,
        onClose: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  static showCustomDialog({required BuildContext context, required String title, required String content}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: kPrimaryColor,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            color: kSecondaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          )
        ],
      ),
    );
  }

  static String formatTimeOfDayToString(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }

  static TimeOfDay formatStringToTimeOfDay(String tod) {
    final format = DateFormat.jm().parse(tod);
    final timeOfDay = TimeOfDay.fromDateTime(format);
    return timeOfDay;
  }

  static String formatDateTimeToString(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static DateTime formatStringToDateTime(String date){
    return DateTime.parse(date);
  }

}

class BookingStatus {
  static String pending = "PENDING";
  static String confirmed = "CONFIRMED";
  static String rejected = "REJECTED";
}
