import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';

class Opportunity extends StatelessWidget {
  const Opportunity(
      {super.key,
      this.onTap,
      required this.image,
      required this.title,
      required this.description});
  final Function()? onTap;
  final String image;
  final String title;
  final String description;

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
            maxHeight: 340.h, // Set your desired maximum height here
          ),
          child: Card(
            color: const Color(0xffFAF0E6),
            elevation: 4.0,
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
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      // height: 0.90,
                      color: Color.fromARGB(255, 198, 134, 99),
                    ),
                  ),
                  verticalSpacing(10),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    description,
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 0.80,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xffD79977),
                    ),
                  ),
                  verticalSpacing(10),
                  Row(
                    children: [
                      Text('Available From  ',
                          style: TextStyle(
                              color: const Color(0xffD79977),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500)),
                      Text('2024-07-01',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 198, 134, 99),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                      Text(' To ',
                          style: TextStyle(
                              color: const Color(0xffD79977),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500)),
                      Text('2024-07-15',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 198, 134, 99),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
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
