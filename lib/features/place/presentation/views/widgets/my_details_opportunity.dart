import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_details_upper.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_location.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_offers.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_requirements.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';

class MyOpportunityDetails extends StatefulWidget {
  const MyOpportunityDetails(
      {super.key, required this.opportunityId, required this.placeId});

  final int opportunityId;
  final int placeId;

  @override
  _MyOpportunityDetailsState createState() => _MyOpportunityDetailsState();
}

class _MyOpportunityDetailsState extends State<MyOpportunityDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OpportunityCubit>(context)
        .getSpecifiOpportunity(widget.opportunityId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<OpportunityCubit, OpportunityState>(
        builder: (context, state) {
          if (state is GetSpecifiOpportunityLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetSpecifiOpportunitySuccess) {
            return ListView(
              children: [
                OpportunityDetailsUpper(
                  image: 'assets/shelter.jpg',
                  title: state.detailsopportunity.title ?? ' ',
                  from: state.detailsopportunity.from ?? '',
                  to: state.detailsopportunity.to ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      verticalSpacing(20),
                      OpportunityOffers(
                        offers: state.detailsopportunity.offers ?? [],
                      ),
                      verticalSpacing(20),
                      OpportunityRequirements(
                        requirements:
                            state.detailsopportunity.requirements ?? [],
                      ),
                      verticalSpacing(20),
                      OpportunityLocation(
                        country: state.detailsopportunity.place?.country ?? '',
                        city: state.detailsopportunity.place?.city ?? ' ',
                        pin: state.detailsopportunity.place?.pin ?? ' ',
                      ),
                      verticalSpacing(20),
                      // if (state.detailsopportunity. == 'open')
                      CloseButton(
                        onTap: () {
                          BlocProvider.of<PlaceCubit>(context)
                              .closeOpportunity(widget.opportunityId);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Failed to load opportunity details'),
            );
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: SizedBox(
        height: 50.h,
        width: 120.w,
        child: const Text(
          'Vonture',
          style: Styles.textlogo,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
        ),
        onPressed: () {
          final placeCubit = BlocProvider.of<PlaceCubit>(context);
          placeCubit.getallplaceopportunity(widget.placeId).then((_) {
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kButtonColor,
        ),
        child: const Text(
          'Close',
          style: TextStyle(
            color: Color(0xFF161411),
            fontSize: 16,
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
