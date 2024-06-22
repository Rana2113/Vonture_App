import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text(
      'Vonture',
      style: Styles.textlogo.copyWith(fontSize: 45.sp, color: PrimaryColor),
    ),
    scrolledUnderElevation: 0,
    backgroundColor: white,
    shadowColor: white,
  );
}
