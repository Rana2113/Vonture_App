import 'package:flutter/material.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

class MeetYourHost extends StatelessWidget {
  const MeetYourHost(
      {super.key,
      required this.fname,
      required this.lname,
      required this.rating});
  final String fname;
  final String lname;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Meet your host',
          style: TextStyle(
            color: kLogoColor,
            fontSize: 22,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpacing(15),
        Align(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/avatar.png"),
              ),
              verticalSpacing(15),
              Text(
                '$fname $lname',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF161111),
                  fontSize: 22,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                rating,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF876B63),
                  fontSize: 16,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
