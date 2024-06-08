import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/customloc.dart';

class AboutPlace extends StatelessWidget {
  const AboutPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About the place',
          style: TextStyle(
            color: kLogoColor,
            fontSize: 22,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        const CustomListTile(
          icon: Icons.location_pin,
          title: 'City',
          subTitle: 'San Francisco, California, United States, San Francisco',
        ),
        const CustomListTile(
          icon: Icons.language,
          title: 'Country',
          subTitle: 'United States',
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
