import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunityCard.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_appbar.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/opportunity_details_view.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/search_opportunity.dart';

class OpportunityViewBody extends StatelessWidget {
  const OpportunityViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpportunityCubit, OpportunityState>(
        builder: (context, state) {
      if (state is OpportunityInitial) {
        BlocProvider.of<OpportunityCubit>(context).getallopportunity();
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is OpportunityLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is OpportunitySuccessState) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: state.opportunityList.length,
            itemBuilder: (context, index) {
              return OpportunityCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpportunityDetails(
                              opportunityId: state.opportunityList[index].id!,
                            )),
                  );
                },
                image: state.opportunityList[index].place!.placeMedia!.isEmpty
                    ? 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'
                    : state.opportunityList[index].place!.placeMedia!.first,
                // (state.opportunityList[index].place!.placeMedia !=
                //             null &&
                //         state.opportunityList[index].place!.placeMedia!
                //             .isNotEmpty)
                //     ? state.opportunityList[index].place!.placeMedia!.first
                //     : 'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg',
                title: state.opportunityList[index].title ?? ' ',
                description: state.opportunityList[index].description ?? ' ',
                from: state.opportunityList[index].from ?? '',
                to: state.opportunityList[index].to ?? '',
                rating: state.opportunityList[index].place!.rating!.toDouble(),
                country: state.opportunityList[index].place!.country!,
              );
            },
          ),
        );
      }
      if (state is OpportunitySearchLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is OpportunitySearchSuccess) {
        if (state.opportunities.isEmpty) {
          return const Center(
            child: Text('No opportunities found'),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: state.opportunities.length,
              itemBuilder: (context, index) {
                return OpportunityCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OpportunityDetails(
                                opportunityId: state.opportunities[index].id!,
                              )),
                    );
                  },
                  image: state.opportunities[index].place!.placeMedia!.isEmpty
                      ? 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'
                      : state.opportunities[index].place!.placeMedia!.first,
                  title: state.opportunities[index].title ?? ' ',
                  description: state.opportunities[index].description ?? ' ',
                  from: state.opportunities[index].from ?? ' ',
                  to: state.opportunities[index].to ?? ' ',
                  rating: state.opportunities[index].place!.rating!.toDouble(),
                  country: state.opportunities[index].place!.country!,
                );
              },
            ),
          );
        }
      } else if (state is OpportunitySearchError) {
        return Column(
          children: [
            const OpportunityAppBar(),
            verticalSpacing(20.h),
            const SearchOpportunity(),
            verticalSpacing(20.h),
            Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
