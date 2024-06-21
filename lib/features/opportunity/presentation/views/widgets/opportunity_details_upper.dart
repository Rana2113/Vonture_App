import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpportunityDetailsUpper extends StatelessWidget {
  const OpportunityDetailsUpper(
      {super.key,
      required this.image,
      required this.title,
      required this.from,
      required this.to});

  final List<String> image;
  final String title;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 300.0,
              aspectRatio: 18 / 9,
              autoPlay: true,
              viewportFraction: 1),
          items: image.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(
                  i,
                  fit: BoxFit.contain,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                );
              },
            );
          }).toList(),
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
