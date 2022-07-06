import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:parkspace/models/area_model.dart';
import 'package:parkspace/models/map_marker_model.dart';
import 'package:parkspace/providers/area_provider.dart';
import 'package:parkspace/providers/booking_provider.dart';
import 'package:parkspace/screens/booking/widgets/booking_widget.dart';
import 'package:parkspace/widgets/stack_card.dart';
import "package:sizer/sizer.dart";
import 'package:provider/provider.dart';


class NewBooking extends StatefulWidget {
  const NewBooking({Key? key}) : super(key: key);

  @override
  State<NewBooking> createState() => _NewBookingState();
}

class _NewBookingState extends State<NewBooking> {
  //
  Set<Marker> markers = {};
  Location location = Location();
  LatLng currentLocation = const LatLng(0, 0);

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read<BookingProvider>().checkForCompletion(context);
      List<MapMarker> mapMarkers = await context.read<AreaProvider>().getMarkers();
      _getMarkers(mapMarkers);
      log(mapMarkers.toString());
      setState(() {
      });
    });
    super.initState();
  }

  _getMarkers(List<MapMarker> mapMarkers) {
    markers = {};
    for (var element in mapMarkers) {
      Marker marker = Marker(
        markerId: element.marker.markerId,
        position: element.marker.position,
        icon: element.marker.icon,
        onTap: () {
          log("Marker Clicked");
          _navigateToBooking(context: context, area: element.area);
        },
      );
      markers.add(marker);
    }
    setState(() {});
  }

  _navigateToBooking({required BuildContext context, required Area area}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => StackCard(
        title: area.areaName,
        onClose: () {
          Navigator.pop(context);
        },
        child: BookingWidget(area: area),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log("Book New Build");
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 80.h,
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.only(left: 3.h, right: 3.h, bottom: 3.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: GoogleMap(
                  onMapCreated: (controller) async {
                    log("Map Created");
                    var locData = await location.getLocation();
                    currentLocation = LatLng(locData.latitude!, locData.longitude!);
                    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation,zoom: 10)));
                  },
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                  ),
                  markers: markers,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

