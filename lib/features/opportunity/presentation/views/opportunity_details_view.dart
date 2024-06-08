import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/about_place.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/meet_your_host.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_details_upper.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_location.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_offers.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_requirements.dart';

class OpportunityDetails extends StatelessWidget {
  const OpportunityDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: ListView(
          children: [
            const OpportunityDetailsUpper(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  verticalSpacing(20),
                  const OpportunityOffers(),
                  verticalSpacing(20),
                  const OpportunityRequirements(),
                  verticalSpacing(20),
                  const OpportunityLocation(),
                  verticalSpacing(20),
                  const AboutPlace(),
                  verticalSpacing(20),
                  MeetYourHost(),
                ],
              ),
            )
          ],
        ));
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    surfaceTintColor: kLogoColor,
    title: SizedBox(
        height: 50.h, width: 120.w, child: Image.asset("assets/LOGO2.png")),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: kLogoColor,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
