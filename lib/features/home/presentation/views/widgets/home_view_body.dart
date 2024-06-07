import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/models/opportunity_model/opportunity_model.dart';
import 'package:vonture_grad/features/home/presentation/managers/cubit/home_cubit.dart';
import 'package:vonture_grad/features/home/presentation/views/widgets/home_appbar_search.dart';
import 'package:vonture_grad/features/home/presentation/views/widgets/opportunity.dart';
import 'package:vonture_grad/features/home/presentation/views/widgets/opportunity_details.dart';
import 'package:vonture_grad/features/home/presentation/views/widgets/search_opportunity.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          BlocProvider.of<HomeCubit>(context)..getallopportunity();
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Homesucess) {
          return _buildOpportunitiesList(context, state.opportunityList);
        } else if (state is HomeSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeSearchsucess) {
          if (state.opportunities.isEmpty) {
            return _buildNoOpportunitiesFound();
          } else {
            return _buildOpportunitiesList(context, state.opportunities);
          }
        } else if (state is HomeSearchError) {
          return _buildSearchError(state.message);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildOpportunitiesList(
      BuildContext context, List<OpportunityModel> opportunities) {
    return Column(
      children: [
        const HomeAppBar(),
        verticalSpacing(20.h),
        const SearchOpportunity(),
        verticalSpacing(20.h),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: opportunities.length,
            itemBuilder: (context, index) {
              return Opportunity(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OpportunityDetails(),
                    ),
                  );
                },
                image: 'assets/shelter.jpg',
                title: opportunities[index].title ?? ' ',
                description: opportunities[index].description ?? ' ',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoOpportunitiesFound() {
    return Column(
      children: [
        const HomeAppBar(),
        verticalSpacing(20.h),
        const SearchOpportunity(),
        verticalSpacing(20.h),
        const Center(
          child: Text('No opportunities found'),
        ),
      ],
    );
  }

  Widget _buildSearchError(String message) {
    return Column(
      children: [
        const HomeAppBar(),
        verticalSpacing(20.h),
        const SearchOpportunity(),
        verticalSpacing(20.h),
        Center(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/features/home/presentation/managers/cubit/home_cubit.dart';
// import 'package:vonture_grad/features/home/presentation/views/widgets/home_appbar_search.dart';
// import 'package:vonture_grad/features/home/presentation/views/widgets/opportunity.dart';
// import 'package:vonture_grad/features/home/presentation/views/widgets/opportunity_details.dart';
// import 'package:vonture_grad/features/home/presentation/views/widgets/search_opportunity.dart';

// class HomeViewBody extends StatelessWidget {
//   const HomeViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
//       if (state is HomeInitial) {
//         BlocProvider.of<HomeCubit>(context).getallopportunity();
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (state is HomeLoading) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (state is Homesucess) {
//         return Column(
//           children: [
//             const HomeAppBar(),
//             verticalSpacing(20.h),
//             const SearchOpportunity(),
//             verticalSpacing(20.h),
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.zero, // Ensure no padding above the list

//                 shrinkWrap: true,
//                 itemCount: state.opportunityList.length,
//                 itemBuilder: (context, index) {
//                   return Opportunity(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const OpportunityDetails()),
//                       );
//                     },
//                     image: 'assets/shelter.jpg',
//                     title: state.opportunityList[index].title ?? ' ',
//                     description:
//                         state.opportunityList[index].description ?? ' ',
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }
//       if (state is HomeSearchLoading) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (state is HomeSearchsucess) {
//         if (state.opportunities.isEmpty) {
//           return const Center(
//             child: Text('No opportunities found'),
//           );
//         } else {
//           return Column(
//             children: [
//               const HomeAppBar(),
//               verticalSpacing(20.h),
//               const SearchOpportunity(),
//               verticalSpacing(20.h),
//               Expanded(
//                 child: ListView.builder(
//                   padding: EdgeInsets.zero, // Ensure no padding above the list

//                   shrinkWrap: true,
//                   itemCount: state.opportunities.length,
//                   itemBuilder: (context, index) {
//                     return Opportunity(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const OpportunityDetails()),
//                         );
//                       },
//                       image: 'assets/shelter.jpg',
//                       title: state.opportunities[index].title ?? ' ',
//                       description:
//                           state.opportunities[index].description ?? ' ',
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }
//       } else if (state is HomeSearchError) {
//         return Column(
//           children: [
//             const HomeAppBar(),
//             verticalSpacing(20.h),
//             const SearchOpportunity(),
//             verticalSpacing(20.h),
//             Center(
//               child: Text(
//                 state.message,
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 16.sp,
//                 ),
//               ),
//             ),
//           ],
//         );
//       }
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     });
//   }
// }
