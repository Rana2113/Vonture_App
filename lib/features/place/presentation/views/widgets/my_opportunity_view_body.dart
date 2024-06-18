import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/my_details_opportunity.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/my_opportunity_card.dart';

class MyOpportunityViewBody extends StatefulWidget {
  const MyOpportunityViewBody({super.key, required this.placeId});
  final int placeId;

  @override
  State<MyOpportunityViewBody> createState() => _MyOpportunityViewBodyState();
}

class _MyOpportunityViewBodyState extends State<MyOpportunityViewBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlaceCubit>(context).getallplaceopportunity(widget.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is GetAllPlaceOpportunityLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetAllPlaceOpportunitySucessState) {
          return ListView.builder(
            itemCount: state.opportunity.length,
            itemBuilder: (context, index) {
              final opportunity = state.opportunity[index];
              return MyOpportunityCard(
                title: opportunity.title ?? 'No title',
                description: opportunity.description ?? 'No description',
                from: opportunity.from ?? 'No from',
                to: opportunity.to ?? 'No to',
                id: opportunity.id!,
                status: opportunity.status!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOpportunityDetails(
                      opportunityId: opportunity.id!,
                      placeId: widget.placeId,
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is GetAllPlaceOpportunityErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: PrimaryColor,
          ));
        }
      },
    );
  }
}

// ListView.builder(
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return MyOpportunityCard(
//             title: 'Siwa Oasis',
//             description: 'Siwa Oasis',
//             onTap: () {},
//             from: '2024-06-01',
//             to: '2024-6-24',
//           );
//         });