import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class OpportunityDescription extends StatelessWidget {
  const OpportunityDescription({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Styles.text18w400.copyWith(color: PrimaryColor),
    );
  }
}
