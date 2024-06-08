import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpportunityDetailsUpper extends StatelessWidget {
  const OpportunityDetailsUpper({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/shelter.jpg",
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
                  'Remote, part time \nopportunity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '\$25/hour · 15 hours/week · 6 months',
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
