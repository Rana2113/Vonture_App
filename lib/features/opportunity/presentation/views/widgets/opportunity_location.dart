import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/customloc.dart';

class OpportunityLocation extends StatelessWidget {
  const OpportunityLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: TextStyle(
            color: kLogoColor,
            fontSize: 22,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        CustomListTile(
          icon: Icons.location_pin,
          title: 'City',
          subTitle: 'San Francisco, California, United States, San Francisco',
        ),
      ],
    );
  }
}
