import 'package:flutter/material.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class Skills extends StatelessWidget {
  const Skills({super.key, required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills & Interests',
            style: Styles.text24w700
                .copyWith(fontSize: 26, fontWeight: FontWeight.w600)),
        verticalSpacing(10),
        ...skills.map((skills) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Text('•  ', style: Styles.text24w700),
                  Flexible(
                    child: Text(skills,
                        style: Styles.text16w500.copyWith(
                            color: PrimaryColor,
                            decoration: TextDecoration.none)),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
