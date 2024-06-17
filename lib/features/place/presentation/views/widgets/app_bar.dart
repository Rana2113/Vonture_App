import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    surfaceTintColor: kLogoColor,
    title: SizedBox(
      height: 50.h,
      width: 120.w,
      child: Image.asset("assets/LOGO2.png"),
    ),
    centerTitle: true,
  );
}
