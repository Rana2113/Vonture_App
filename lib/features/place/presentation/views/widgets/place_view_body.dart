import 'package:flutter/material.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/place_card.dart';

class PlaceViewBody extends StatelessWidget {
  const PlaceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const PlaceCard();
        },
      ),
    );
  }
}
