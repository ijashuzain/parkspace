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

class ManagerNewArea extends StatefulWidget {
  final LatLng location;
  final bool isEdit;
  final Area? area;
  ManagerNewArea({Key? key, required this.location, this.isEdit = false, this.area}) : super(key: key);

  @override
  State<ManagerNewArea> createState() => _ManagerNewAreaState();
}

class _ManagerNewAreaState extends State<ManagerNewArea> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController slotsController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  bool? cameraStatus;
  bool? nightParking;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      if (widget.isEdit) {
        nameController.text = widget.area!.areaName;
        addressController.text = widget.area!.areaAddress;
        slotsController.text = widget.area!.slots.toString();
        rateController.text = widget.area!.rate.toString();
        cameraStatus = widget.area!.cameraStatus;
        nightParking = widget.area!.nightParking;
      }
    });
    super.initState();
  }

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
            value: cameraStatus ?? true,
            title: "Camera Status",
            onSelected: (val) {
              cameraStatus = val;
            },
          ),
          CRadioField(
            value: nightParking ?? true,
            title: "Night Parking",
            onSelected: (val) {
              nightParking = val;
            },
          ),
          const Spacer(),
          Consumer<AreaProvider>(builder: (context, provider, child) {
            return widget.isEdit
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CButton(
                        isDisabled: provider.creatingArea,
                        isLoading: provider.creatingArea,
                        title: "Update",
                        onTap: () async {
                          provider.updateArea(
                            context: context,
                            area: Area(
                              id: widget.area!.id,
                              uid: widget.area!.uid,
                              areaName: nameController.text,
                              areaAddress: addressController.text,
                              slots: int.parse(slotsController.text),
                              cameraStatus: cameraStatus ?? true,
                              nightParking: nightParking ?? true,
                              bookedSlots: 0,
                              latitude: widget.location.latitude.toString(),
                              longitude: widget.location.longitude.toString(),
                              rate: int.parse(rateController.text),
                            ),
                            onSuccess: (val) {
                              Navigator.pop(context);
                              Globals.showCustomDialog(
                                context: context,
                                title: "Success",
                                content: "Area updated successfully",
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
                      ),
                      CButton(
                        isDisabled: provider.creatingArea,
                        isLoading: provider.creatingArea,
                        title: "Delete",
                        onTap: () async {
                          provider.deleteArea(
                            context: context,
                            areaId: widget.area!.id,
                            onSuccess: (val) {
                              Navigator.pop(context);
                              Globals.showCustomDialog(
                                context: context,
                                title: "Success",
                                content: "Area Deleted successfully",
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
                      ),
                    ],
                  )
                : CButton(
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
                          cameraStatus: cameraStatus ?? true,
                          nightParking: nightParking ?? true,
                          bookedSlots: 0,
                          latitude: widget.location.latitude.toString(),
                          longitude: widget.location.longitude.toString(),
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
