import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 390.w,
        height: 218.h,
        decoration: BoxDecoration(
          image:
              DecorationImage(fit: BoxFit.fitWidth, image: AssetImage(image)),
        ));
  }
}
