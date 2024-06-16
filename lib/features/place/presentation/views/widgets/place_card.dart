import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

class PlaceCard extends StatelessWidget {
  final String title;
  final String country;
  final String rating;

  const PlaceCard({
    super.key,
    required this.title,
    required this.country,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 16.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Card(
        color: kCardColor,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/siwa.jpg',
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            verticalSpacing(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff8C6B59),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            verticalSpacing(8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                country,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff8C6B59),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            verticalSpacing(4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Rating: $rating',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff8C6B59),
                ),
              ),
            ),
            verticalSpacing(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kLogoColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Add Opportunity',
                  style: TextStyle(
                    color: Color(0xff8C6B59),
                  ),
                ),
              ),
            ),
            verticalSpacing(16.h),
          ],
        ),
      ),
    );
  }
}
