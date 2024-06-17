import 'package:flutter/material.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/add_opportunity_view_body.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/app_bar.dart';

class AddOpportunityView extends StatelessWidget {
  const AddOpportunityView({super.key, required this.placeId});
  final int placeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: AddOpportunityViewBody(
        placeId: placeId,
      ),
    );
  }
}
