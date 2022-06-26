import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class BookingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final Color color;
  final String status;
  final VoidCallback onTap;
  const BookingCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.color,
    required this.onTap,
    required this.status,
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
                child: Stack(
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Row(
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: kPrimaryColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(1.w),
                                    border: Border.all(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 2.w, left: 2.w),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8.sp,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            subtitle,
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
                              SizedBox(
                                width: 25.w,
                                child: Text(
                                  fromDate,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: kPrimaryColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Icon(
                                Icons.arrow_forward,
                                size: 12.sp,
                                color: kPrimaryColor,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                toDate,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: kPrimaryColor,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 25.w,
                                child: Text(
                                  fromTime,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 10.sp,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Icon(
                                Icons.arrow_forward,
                                size: 12.sp,
                                color: kPrimaryColor,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                toTime,
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
