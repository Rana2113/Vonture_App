import 'package:cached_network_image/cached_network_image.dart';
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
          height: additionalWidget != null ? 280.h : 200.h,
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
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 110.h,
                      width: 150.h,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: PrimaryColor,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
