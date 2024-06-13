import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpportunityDetailsUpper extends StatelessWidget {
  const OpportunityDetailsUpper(
      {super.key,
      required this.image,
      required this.title,
      required this.from,
      required this.to});
  final String image;
  final String title;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          image,
          height: 350.h,
          width: 600.w,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 30.h,
          left: 30.w,
          child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Available from $from to $to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
