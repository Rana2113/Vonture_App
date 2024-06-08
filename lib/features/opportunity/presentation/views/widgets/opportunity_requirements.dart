import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

class OpportunityRequirements extends StatelessWidget {
  const OpportunityRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Requirements',
          style: TextStyle(
            color: kLogoColor,
            fontSize: 22,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 25),
        Row(
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
                '5+ years of experience in marketing or related field',
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
        SizedBox(height: 15),
        Row(
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
        SizedBox(height: 15),
        Row(
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
