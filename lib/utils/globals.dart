import 'package:flutter/material.dart';
import 'package:parkspace/widgets/stack_card.dart';

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
}

class BookingStatus {
  static String pending = "PENDING";
  static String confirmed = "CONFIRMED";
  static String rejected = "REJECTED";
}
