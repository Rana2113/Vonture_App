import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/apply_button.dart';

class MeetYourHost extends StatelessWidget {
  const MeetYourHost({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meet your host',
          style: TextStyle(
            color: kLogoColor,
            fontSize: 22,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 15),
        Align(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
              SizedBox(height: 15),
              Text(
                'Linda K.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF161111),
                  fontSize: 22,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Senior Marketing Manager at Apple',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF876B63),
                  fontSize: 16,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 48),
              ApplyButton(),
            ],
          ),
        ),
      ],
    );
  }
}
