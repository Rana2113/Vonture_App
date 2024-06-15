import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

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
            color: kCardColor,
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
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 198, 134, 99),
                        ),
                      ),
                      verticalSpacing(8),
                      Text(
                        dateRange,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xff8C6B59),
                        ),
                      ),
                      verticalSpacing(8),
                      Text(
                        'Status: $status',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xff8C6B59),
                        ),
                      ),
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
                    width: 80.w,
                    height: 60.sp,
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
