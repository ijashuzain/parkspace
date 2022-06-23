import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/radio_field.dart';
import 'package:parkspace/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class ManagerNewArea extends StatelessWidget {
  ManagerNewArea({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController slotsController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  bool cameraStatus = true;
  bool nightParking = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 75.h,
      child: Column(
        children: [
          CTextField(
            controller: nameController,
            hint: "Area Name",
          ),
          CTextField(
            controller: locationController,
            hint: "Area Address",
          ),
          CTextField(
            controller: slotsController,
            hint: "Slots",
          ),
          CTextField(
            controller: rateController,
            hint: "Rate/hr",
          ),
          CRadioField(
            title: "Camera Status",
            onSelected: (val) {},
          ),
          CRadioField(
            title: "Night Parking",
            onSelected: (val) {},
          ),
          const Spacer(),
          CButton(
            title: "Submit",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
