import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard(
      {super.key,
      this.onTap,
      required this.image,
      required this.title,
      required this.description,
      required this.from,
      required this.to});
  final Function()? onTap;
  final String image;
  final String title;
  final String description;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
          left: 16.0,
          right: 16,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 360.h,
          ),
          child: Card(
            color: Color.fromARGB(255, 233, 242, 246),
            //  Color.fromARGB(255, 217, 236, 245),  Color.fromARGB(255, 224, 239, 246),
            elevation: 7.0,

            shadowColor: PrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      image,
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  verticalSpacing(10),
                  Text(title,
                      style: Styles.text20w600.copyWith(
                          color: PrimaryColor, fontWeight: FontWeight.w900)),
                  verticalSpacing(10),
                  Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      description,
                      style: Styles.text16w600
                          .copyWith(height: 0.80, color: PrimaryColor)),
                  verticalSpacing(10),
                  Row(
                    children: [
                      Text('Available From  ',
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400)),
                      Text(from,
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500)),
                      Text(' To ',
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400)),
                      Text(to,
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
