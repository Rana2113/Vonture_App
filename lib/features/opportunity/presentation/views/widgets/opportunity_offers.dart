import 'package:flutter/material.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class OpportunityOffers extends StatelessWidget {
  const OpportunityOffers({super.key, required this.offers});

  final List<String> offers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Offers', style: Styles.text24w700),
        verticalSpacing(20),
        ...offers.map((offer) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Text('•  ', style: Styles.text24w700),
                  Flexible(
                    child: Text(offer,
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
