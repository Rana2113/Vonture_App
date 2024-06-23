import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.size,
      required this.heigh,
      required this.onPressed,
      required this.width});
  final String text;
  final double size, heigh;
  final void Function() onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: PrimaryColor,
        ),
        width: width,
        height: heigh,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
            child: Text(
              text,
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w700,
                height: 0.11.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
