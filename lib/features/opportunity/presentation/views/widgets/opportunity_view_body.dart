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
                image: 'assets/shelter.jpg',
                title: state.opportunityList[index].title ?? ' ',
                description: state.opportunityList[index].description ?? ' ',
                from: state.opportunityList[index].from ?? '',
                to: state.opportunityList[index].to ?? '',
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
                  image: 'assets/shelter.jpg',
                  title: state.opportunities[index].title ?? ' ',
                  description: state.opportunities[index].description ?? ' ',
                  from: state.opportunities[index].from ?? ' ',
                  to: state.opportunities[index].to ?? ' ',
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
