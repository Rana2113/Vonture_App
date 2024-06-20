import 'package:flutter/material.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/customloc.dart';

class AboutPlace extends StatelessWidget {
  const AboutPlace({super.key, required this.country});
  final String country;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('About the place', style: Styles.text24w700),
        verticalSpacing(20),
        CustomListTile(
          icon: Icons.language,
          title: 'Country',
          subTitle: country,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: const Image(
              image: AssetImage(
            'assets/shelter.jpg',
          )),
        )
      ],
    );
  }
}
