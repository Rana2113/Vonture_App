import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class ApplicationCard extends StatelessWidget {
  final String title;
  final String dateRange;
  final String status;
  final String imageUrl;
  final Widget? additionalWidget;

  const ApplicationCard({
    super.key,
    required this.title,
    required this.dateRange,
    required this.status,
    required this.imageUrl,
    this.additionalWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpacing(16),
        Container(
          height: additionalWidget != null ? 210.h : 140.h,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style:
                              Styles.text16w500.copyWith(color: PrimaryColor)),
                      verticalSpacing(8),
                      Text(dateRange,
                          style: Styles.text14w600.copyWith(
                              color: PrimaryColor,
                              fontWeight: FontWeight.w400,
                              height: 1)),
                      verticalSpacing(8),
                      Text('$status',
                          style: Styles.text14w600.copyWith(
                              color: PrimaryColor,
                              fontWeight: FontWeight.w500,
                              height: 1)),
                      if (additionalWidget != null) ...[
                        verticalSpacing(8),
                        additionalWidget!,
                      ]
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageUrl,
                    width: 130.w,
                    height: 150.sp,
                    fit: BoxFit.cover,
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
