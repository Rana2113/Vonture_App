import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/customloc.dart';

class AboutPlace extends StatelessWidget {
  const AboutPlace({super.key, required this.country, required this.image});
  final String country;
  final List<String> image;

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
        verticalSpacing(20),
        CarouselSlider(
          options: CarouselOptions(
              height: 300.0, autoPlay: true, viewportFraction: 1),
          items: image.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(
                  i,
                  fit: BoxFit.contain,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
