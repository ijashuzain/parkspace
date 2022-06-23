import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:sizer/sizer.dart';

class StackCard extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback onClose;
  const StackCard({
    Key? key,
    required this.child,
    required this.title,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 87.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(3.h),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
                width: 100.h,
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        onClose();
                      },
                      child: Container(
                        height: 6.w,
                        width: 6.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: kSecondaryColor,
                          ),
                        ),
                        child:  Icon(Icons.close,size: 4.w,),
                      ),
                    )
                  ],
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
