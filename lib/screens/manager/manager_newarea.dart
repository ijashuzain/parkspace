import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/models/area_model.dart';
import 'package:parkspace/providers/area_provider.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/radio_field.dart';
import 'package:parkspace/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ManagerNewArea extends StatelessWidget {
  final LatLng location;

  ManagerNewArea({Key? key, required this.location}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
            controller: addressController,
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
            onSelected: (val) {
              cameraStatus = val;
            },
          ),
          CRadioField(
            title: "Night Parking",
            onSelected: (val) {
              nightParking = val;
            },
          ),
          const Spacer(),
          Consumer<AreaProvider>(builder: (context, provider, child) {
            return CButton(
              isDisabled: provider.creatingArea,
              isLoading: provider.creatingArea,
              title: "Submit",
              onTap: () async {
                provider.createArea(
                  context: context,
                  area: Area(
                    areaName: nameController.text,
                    areaAddress: addressController.text,
                    slots: int.parse(slotsController.text),
                    cameraStatus: cameraStatus,
                    nightParking: nightParking,
                    bookedSlots: 0,
                    latitude: location.latitude.toString(),
                    longitude: location.longitude.toString(),
                    rate: int.parse(rateController.text),
                  ),
                  onSuccess: (val) {
                    Navigator.pop(context);
                    Globals.showCustomDialog(
                      context: context,
                      title: "Success",
                      content: "New area created successfully",
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
              },
            );
          }),
        ],
      ),
    );
  }
}
