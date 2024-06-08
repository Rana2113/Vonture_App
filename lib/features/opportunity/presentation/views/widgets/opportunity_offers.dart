import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

class OpportunityOffers extends StatelessWidget {
  const OpportunityOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Offers',
          style: TextStyle(
            color: kLogoColor,
            fontSize: 22.sp,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpacing(10),
        const Row(
          children: [
            Text(
              '•  ',
              style: TextStyle(
                color: Color(0xFF161111),
                fontSize: 16,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
            Flexible(
              child: Text(
                'You will be responsible for managing .',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF161111),
                  fontSize: 16,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Row(
          children: [
            Text(
              '•  ',
              style: TextStyle(
                color: Color(0xFF161111),
                fontSize: 16,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
            Flexible(
              child: Text(
                'Experience with product marketing',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF161111),
                  fontSize: 16,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Row(
          children: [
            Text(
              '•  ',
              style: TextStyle(
                color: Color(0xFF161111),
                fontSize: 16,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
            Flexible(
              child: Text(
                'Strong project management skills',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF161111),
                  fontSize: 16,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
