import 'package:flutter/material.dart';
import 'package:parkspace/screens/manager/manager_newarea.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:sizer/sizer.dart';

class ManagerNewMap extends StatelessWidget {
  const ManagerNewMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Globals.showStackSheet(
          context: context,
          child: ManagerNewArea(),
          title: "Create Parking Area",
        );
      },
      child: SizedBox(
        width: 100.w,
        height: 75.h,
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
