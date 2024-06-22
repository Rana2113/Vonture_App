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
    _fetchOpportunity();
  }

  void _fetchOpportunity() {
    BlocProvider.of<PlaceCubit>(context).getallplaceopportunity(widget.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is GetAllPlaceOpportunityLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: PrimaryColor,
            ),
          );
        } else if (state is GetAllPlaceOpportunitySucessState) {
          return ListView.builder(
            itemCount: state.opportunity.length,
            itemBuilder: (context, index) {
              final opportunity = state.opportunity[index];
              return MyOpportunityCard(
                title: opportunity.title ?? 'No title',
                description: opportunity.place!.city ?? 'No description',
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
                ).then((value) {
                  if (value == true) {
                    _fetchOpportunity();
                  }
                }),
                image: opportunity.place!.placeMedia!.isEmpty
                    ? 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'
                    : opportunity.place!.placeMedia!.first,
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
