import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class AreaCard extends StatelessWidget {
  final String name;
  final String address;
  final bool nightParking;
  final bool cameraStatus;
  final int slots;
  final int rate;
  final Color color;
  final VoidCallback onTap;
  const AreaCard({
    Key? key,
    required this.name,
    required this.address,
    required this.color,
    required this.onTap,
    required this.nightParking,
    required this.cameraStatus,
    required this.slots,
    required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          width: 100.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.h), border: Border.all(color: kSecondaryColor)),
          child: Row(
            children: [
              Container(
                height: 6.h,
                width: 0.5.w,
                color: color,
              ),
              Padding(
                padding: EdgeInsets.all(3.w),
                child: SizedBox(
                  width: 80.w,
                  height: 12.h,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kPrimaryColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            address,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 9.sp,
                              color: kSecondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Icon(
                                Icons.nightlight_round,
                                color: kPrimaryColor,
                                size: 12.sp,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                "Night Parking ${nightParking ? 'Available' : 'Not Available'}",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 9.sp,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          Row(
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                color: kPrimaryColor,
                                size: 12.sp,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                "Camera ${cameraStatus ? 'Available' : 'Not Available'}",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 9.sp,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "$rate/hr",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kPrimaryColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "$slots Slots",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kPrimaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
