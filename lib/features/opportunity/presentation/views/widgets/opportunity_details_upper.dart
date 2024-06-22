import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OpportunityDetailsUpper extends StatelessWidget {
  const OpportunityDetailsUpper({
    super.key,
    required this.image,
  });

  final List<String> image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 300.0,
              aspectRatio: 18 / 9,
              autoPlay: true,
              viewportFraction: 1),
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
