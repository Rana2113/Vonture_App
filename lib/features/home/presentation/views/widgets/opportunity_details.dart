import 'package:flutter/material.dart';
import 'package:vonture_grad/features/home/presentation/views/widgets/opportunity.dart';

class OpportunityDetails extends StatelessWidget {
  const OpportunityDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Opportunity(
        image: 'assets/shelter.jpg',
        title: 'Osis Farm',
        description: 'Siwa Oasis Farm',
      ),
    );
  }
}
