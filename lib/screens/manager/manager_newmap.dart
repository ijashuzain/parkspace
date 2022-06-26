import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/manager/manager_newarea.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:sizer/sizer.dart';

class ManagerNewMap extends StatefulWidget {
  const ManagerNewMap({Key? key}) : super(key: key);

  @override
  State<ManagerNewMap> createState() => _ManagerNewMapState();
}

class _ManagerNewMapState extends State<ManagerNewMap> {
  Marker? marker;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 75.h,
      child: Stack(
        children: [
          SizedBox(
            width: 100.w,
            height: 75.h,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
              ),
              markers: marker != null ? {marker!} : {},
              onTap: (val) {
                log(val.latitude.toString());
                marker = Marker(
                  markerId: const MarkerId('locationId'),
                  position: val,
                  icon: BitmapDescriptor.defaultMarker,
                );
                setState(() {});
              },
            ),
          ),
          if (marker != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.pop(context);
                    Globals.showStackSheet(
                      context: context,
                      child: ManagerNewArea(
                        location: marker!.position,
                      ),
                      title: "Create Parking Area",
                    );
                  },
                ),
              ),
            )
        ],
      ),
    );
  }
}
