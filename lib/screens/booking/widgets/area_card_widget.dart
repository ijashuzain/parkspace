import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/booking/widgets/area_data_widget.dart';
import 'package:sizer/sizer.dart';

class AreaDetailCard extends StatelessWidget {
  final String availableSlots;
  final String ratePerHour;
  final String location;
  final bool cameraStatus;
  final bool nightParking;

  const AreaDetailCard({
    Key? key,
    required this.availableSlots,
    required this.ratePerHour,
    required this.location,
    required this.cameraStatus,
    required this.nightParking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                AreaData(
                  title: "Available Slots",
                  value: availableSlots,
                  width: 35.w,
                ),
                const Spacer(),
                const VerticalDivider(color: kSecondaryColor),
                const Spacer(),
                AreaData(
                  title: "Rate Per Hour",
                  value: ratePerHour,
                  width: 35.w,
                  isLeftAligned: false,
                ),
                const Spacer(),
              ],
            ),
          ),
          const Divider(color: kSecondaryColor),
          SizedBox(
            width: 100.w,
            child: Row(
              children: [
                AreaData(
                  title: "Location",
                  value: location,
                  width: 60.w,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50.h,
                          width: 90.w,
                          color: Colors.white,
                          child: const Center(
                            child: Text("Will be redirected to google map"),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ),
          const Divider(color: kSecondaryColor),
          SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                AreaData(
                  title: "Camera Status",
                  value: cameraStatus ? "Available" : "Not Available",
                  width: 35.w,
                ),
                const Spacer(),
                const VerticalDivider(color: kSecondaryColor),
                const Spacer(),
                AreaData(
                  title: "Night Parking",
                  value: nightParking ? "Available" : "Not Available",
                  isLeftAligned: false,
                  width: 35.w,
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
