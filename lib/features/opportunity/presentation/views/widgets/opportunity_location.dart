import 'package:flutter/material.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/customloc.dart';

class OpportunityLocation extends StatelessWidget {
  const OpportunityLocation(
      {super.key,
      required this.country,
      required this.city,
      required this.pin});
  final String country;
  final String city;
  final String pin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Location', style: Styles.text24w700),
        verticalSpacing(20),
        CustomListTile(
          icon: Icons.location_pin,
          title: country,
          subTitle: '$city, $pin ',
        ),
      ],
    );
  }
}
