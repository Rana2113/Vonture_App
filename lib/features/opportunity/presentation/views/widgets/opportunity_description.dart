import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class OpportunityDescription extends StatelessWidget {
  const OpportunityDescription(
      {super.key,
      required this.description,
      required this.title,
      required this.from,
      required this.to});
  final String description;
  final String title;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpacing(20),
        Text(title,
            style: Styles.text24w700
                .copyWith(color: PrimaryColor, fontSize: 30.sp, height: 1.5)),
        verticalSpacing(20),
        Text(description,
            style: Styles.text24w700.copyWith(
                color: PrimaryColor,
                fontSize: 24.sp,
                height: 1.2,
                fontWeight: FontWeight.w500)),
        verticalSpacing(20),
        Text('$from to $to',
            style: Styles.text18w400.copyWith(color: PrimaryColor, height: 2)),
        // verticalSpacing(12),
        // Text(
        //   description,
        //   style: Styles.text18w400.copyWith(color: PrimaryColor, height: 1.3),
        // ),
      ],
    );
  }
}
