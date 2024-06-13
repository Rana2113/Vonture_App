// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/core/constants.dart/api_constants.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';
// import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/about_place.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/apply_button.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/meet_your_host.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_details_upper.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_location.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_offers.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_requirements.dart';

// class OpportunityDetails extends StatelessWidget {
//   const OpportunityDetails({Key? key, required this.opportunityId});

//   final int opportunityId;

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<OpportunityCubit>(context)
//         .getSpecifiOpportunity(opportunityId);

//     final userRoleBox = Hive.box(kRoleBoxString);
//     String? role = userRoleBox.get(kRoleBoxString);
//     final userTouristApplicationsBox = Hive.box(kTouristApplicationsBoxString);
//     List<int>? touristApplications = (userTouristApplicationsBox
//             .get(kTouristApplicationsBoxString) as List<dynamic>?)
//         ?.map((e) => e as int)
//         .toList();

//     bool hasApplied = touristApplications?.contains(opportunityId) ?? false;

//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: BlocConsumer<OpportunityCubit, OpportunityState>(
//         listener: (context, state) {
//           if (state is ApplyOpportunitySuccess) {
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(
//                 const SnackBar(
//                   content: Text('Applied successfully!'),
//                   duration: Duration(seconds: 2),
//                 ),
//               );

//             // Update touristApplications after successful application
//             touristApplications?.add(opportunityId);
//             userTouristApplicationsBox.put(
//                 kTouristApplicationsBoxString, touristApplications);

//             // After applying successfully, refresh the specific opportunity
//             BlocProvider.of<OpportunityCubit>(context)
//                 .getSpecifiOpportunity(opportunityId);
//           }
//         },
//         builder: (context, state) {
//           if (state is GetSpecifiOpportunityLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is GetSpecifiOpportunitySuccess) {
//             return ListView(
//               children: [
//                 OpportunityDetailsUpper(
//                   image: 'assets/shelter.jpg',
//                   title: state.detailsopportunity.title ?? ' ',
//                   from: state.detailsopportunity.from?.toIso8601String() ?? '',
//                   to: state.detailsopportunity.to?.toIso8601String() ?? '',
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     children: [
//                       verticalSpacing(20),
//                       const OpportunityOffers(),
//                       verticalSpacing(20),
//                       const OpportunityRequirements(),
//                       verticalSpacing(20),
//                       OpportunityLocation(
//                         country: state.detailsopportunity.place?.country ?? '',
//                         city: state.detailsopportunity.place?.city ?? ' ',
//                         pin: state.detailsopportunity.place?.pin ?? ' ',
//                       ),
//                       verticalSpacing(20),
//                       AboutPlace(
//                         country: state.detailsopportunity.place?.country ?? ' ',
//                       ),
//                       verticalSpacing(20),
//                       MeetYourHost(
//                         fname: state.detailsopportunity.host?.firstName ?? '',
//                         lname: state.detailsopportunity.host?.lastName ?? '',
//                         rating:
//                             state.detailsopportunity.host?.rating?.toString() ??
//                                 '',
//                       ),
//                       verticalSpacing(48),
//                       if (role == 'TOURIST')
//                         hasApplied
//                             ? Text(
//                                 'Already applied',
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 16.sp,
//                                 ),
//                               )
//                             : ApplyButton(
//                                 onTap: () {
//                                   BlocProvider.of<OpportunityCubit>(context)
//                                       .applyOpportunity(opportunityId);
//                                   touristApplications?.add(opportunityId);
//                                   print('tourist appppp${touristApplications}');
//                                 },
//                               ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: kPrimaryColor,
//       surfaceTintColor: kLogoColor,
//       title: SizedBox(
//         height: 50.h,
//         width: 120.w,
//         child: Image.asset("assets/LOGO2.png"),
//       ),
//       centerTitle: true,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back,
//           color: kLogoColor,
//         ),
//         onPressed: () {
//           final opportunityCubit = BlocProvider.of<OpportunityCubit>(context);
//           opportunityCubit.getallopportunity().then((_) {
//             Navigator.pop(context);
//           });
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/core/constants.dart/api_constants.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';
// import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/about_place.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/apply_button.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/meet_your_host.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_details_upper.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_location.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_offers.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_requirements.dart';

// class OpportunityDetails extends StatelessWidget {
//   const OpportunityDetails({super.key, required this.opportunityId});

//   final int opportunityId;

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<OpportunityCubit>(context)
//         .getSpecifiOpportunity(opportunityId);

//     final userRoleBox = Hive.box(kRoleBoxString);
//     String? role = userRoleBox.get(kRoleBoxString);
//     final userTouristApplicationsBox = Hive.box(kTouristApplicationsBoxString);
//     List<int>? touristApplications = (userTouristApplicationsBox
//             .get(kTouristApplicationsBoxString) as List<dynamic>?)
//         ?.map((e) => e as int)
//         .toList();

//     bool hasApplied = touristApplications?.contains(opportunityId) ?? false;

//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: BlocConsumer<OpportunityCubit, OpportunityState>(
//         listener: (context, state) {
//           if (state is ApplyOpportunitySuccess) {
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(
//                 const SnackBar(
//                   content: Text('Applied successfully!'),
//                   duration: Duration(seconds: 2),
//                 ),
//               );

//             // Update touristApplications after successful application
//             touristApplications?.add(opportunityId);
//             userTouristApplicationsBox.put(
//                 kTouristApplicationsBoxString, touristApplications);

//             // After applying successfully, refresh the specific opportunity
//             BlocProvider.of<OpportunityCubit>(context)
//                 .getSpecifiOpportunity(opportunityId);
//           }
//         },
//         builder: (context, state) {
//           if (state is GetSpecifiOpportunityLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is GetSpecifiOpportunitySuccess) {
//             return ListView(
//               children: [
//                 OpportunityDetailsUpper(
//                   image: 'assets/shelter.jpg',
//                   title: state.detailsopportunity.title ?? ' ',
//                   from: state.detailsopportunity.from?.toIso8601String() ?? '',
//                   to: state.detailsopportunity.to?.toIso8601String() ?? '',
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     children: [
//                       verticalSpacing(20),
//                       const OpportunityOffers(),
//                       verticalSpacing(20),
//                       const OpportunityRequirements(),
//                       verticalSpacing(20),
//                       OpportunityLocation(
//                         country: state.detailsopportunity.place?.country ?? '',
//                         city: state.detailsopportunity.place?.city ?? ' ',
//                         pin: state.detailsopportunity.place?.pin ?? ' ',
//                       ),
//                       verticalSpacing(20),
//                       AboutPlace(
//                         country: state.detailsopportunity.place?.country ?? ' ',
//                       ),
//                       verticalSpacing(20),
//                       MeetYourHost(
//                         fname: state.detailsopportunity.host?.firstName ?? '',
//                         lname: state.detailsopportunity.host?.lastName ?? '',
//                         rating:
//                             state.detailsopportunity.host?.rating?.toString() ??
//                                 '',
//                       ),
//                       verticalSpacing(48),
//                       if (role == 'TOURIST')
//                         hasApplied
//                             ? Text(
//                                 'Already applied',
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 16.sp,
//                                 ),
//                               )
//                             : ApplyButton(
//                                 onTap: () {
//                                   BlocProvider.of<OpportunityCubit>(context)
//                                       .applyOpportunity(opportunityId);
//                                 },
//                               ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: kPrimaryColor,
//       surfaceTintColor: kLogoColor,
//       title: SizedBox(
//         height: 50.h,
//         width: 120.w,
//         child: Image.asset("assets/LOGO2.png"),
//       ),
//       centerTitle: true,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back,
//           color: kLogoColor,
//         ),
//         onPressed: () {
//           final opportunityCubit = BlocProvider.of<OpportunityCubit>(context);
//           opportunityCubit.getallopportunity().then((_) {
//             Navigator.pop(context);
//           });
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/about_place.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/apply_button.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/meet_your_host.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_details_upper.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_location.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_offers.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_requirements.dart';

class OpportunityDetails extends StatefulWidget {
  const OpportunityDetails({Key? key, required this.opportunityId})
      : super(key: key);

  final int opportunityId;

  @override
  _OpportunityDetailsState createState() => _OpportunityDetailsState();
}

class _OpportunityDetailsState extends State<OpportunityDetails> {
  bool hasApplied = false;
  List<int> touristApplications = [];

  @override
  void initState() {
    super.initState();
    checkIfApplied();
  }

  void checkIfApplied() {
    final userTouristApplicationsBox = Hive.box(kTouristApplicationsBoxString);
    touristApplications = (userTouristApplicationsBox
                .get(kTouristApplicationsBoxString) as List<dynamic>?)
            ?.map((e) => e as int)
            .toList() ??
        [];

    setState(() {
      hasApplied = touristApplications.contains(widget.opportunityId);
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OpportunityCubit>(context)
        .getSpecifiOpportunity(widget.opportunityId);

    final userRoleBox = Hive.box(kRoleBoxString);
    String? role = userRoleBox.get(kRoleBoxString);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<OpportunityCubit, OpportunityState>(
        listener: (context, state) {
          if (state is ApplyOpportunitySuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Applied successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );

            // Update hasApplied and touristApplications after successful application
            setState(() {
              hasApplied = true;
              touristApplications.add(widget.opportunityId);
            });

            // Update Hive with updated touristApplications
            final userTouristApplicationsBox =
                Hive.box(kTouristApplicationsBoxString);
            userTouristApplicationsBox.put(
                kTouristApplicationsBoxString, touristApplications);

            // After applying successfully, refresh the specific opportunity
            BlocProvider.of<OpportunityCubit>(context)
                .getSpecifiOpportunity(widget.opportunityId);
          }
        },
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
                      const OpportunityOffers(),
                      verticalSpacing(20),
                      const OpportunityRequirements(),
                      verticalSpacing(20),
                      OpportunityLocation(
                        country: state.detailsopportunity.place?.country ?? '',
                        city: state.detailsopportunity.place?.city ?? ' ',
                        pin: state.detailsopportunity.place?.pin ?? ' ',
                      ),
                      verticalSpacing(20),
                      AboutPlace(
                        country: state.detailsopportunity.place?.country ?? ' ',
                      ),
                      verticalSpacing(20),
                      MeetYourHost(
                        fname: state.detailsopportunity.host?.firstName ?? '',
                        lname: state.detailsopportunity.host?.lastName ?? '',
                        rating:
                            state.detailsopportunity.host?.rating?.toString() ??
                                '',
                      ),
                      verticalSpacing(48),
                      if (role == 'TOURIST')
                        hasApplied
                            ? Text(
                                'Already applied',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.sp,
                                ),
                              )
                            : ApplyButton(
                                onTap: () {
                                  BlocProvider.of<OpportunityCubit>(context)
                                      .applyOpportunity(widget.opportunityId);
                                },
                              ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      surfaceTintColor: kLogoColor,
      title: SizedBox(
        height: 50.h,
        width: 120.w,
        child: Image.asset("assets/LOGO2.png"),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: kLogoColor,
        ),
        onPressed: () {
          final opportunityCubit = BlocProvider.of<OpportunityCubit>(context);
          opportunityCubit.getallopportunity().then((_) {
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}
