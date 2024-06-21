import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/about_place.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/apply_button.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/meet_your_host.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_description.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_details_upper.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_location.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_offers.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_requirements.dart';

import '../../../../core/models/opportunity_model/opportunity_model.dart';
import '../../../place/data/models/profile _model/profile_model.dart';
import '../../../place/presentation/manager/cubit/place_cubit.dart';
import '../../../place/presentation/views/widgets/my_details_opportunity.dart';

class OpportunityDetails extends StatefulWidget {
  OpportunityDetails(
      {Key? key, required this.opportunityId, this.isApllication})
      : super(key: key);

  final int opportunityId;
  bool? isApllication;

  @override
  _OpportunityDetailsState createState() => _OpportunityDetailsState();
}

class _OpportunityDetailsState extends State<OpportunityDetails> {
  bool hasApplied = false;
  List<int> touristApplications = [];
  TextEditingController commentController = TextEditingController();

  double rating=0.0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OpportunityCubit>(context)
        .getSpecifiOpportunity(widget.opportunityId);
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
                  image: state.detailsopportunity.place!.placeMedia??[],
                  title: state.detailsopportunity.title ?? ' ',
                  from: state.detailsopportunity.from ?? '',
                  to: state.detailsopportunity.to ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OpportunityDescription(
                          description:
                          state.detailsopportunity.description ?? ''),
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
                      verticalSpacing(20),
                      widget.isApllication == null
                          ? role == 'TOURIST'
                          ? hasApplied
                          ? Center(
                        child: Text(
                          'Already applied',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.sp,
                          ),
                        ),
                      )
                          : ApplyButton(
                        onTap: () {
                          BlocProvider.of<OpportunityCubit>(
                              context)
                              .applyOpportunity(
                              widget.opportunityId);
                        },
                      )
                          : SizedBox()
                          : Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...(state.detailsopportunity.place!.touristReviews?? [])
                              .map((review) => displayRating(review)),
                          const SizedBox(height: 10,),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: PrimaryColor,
                            ),
                            onRatingUpdate: (newRating) {

                                rating = newRating;
                            },
                          ),
                          const SizedBox(height: 10,),

                          TextField(
                            controller: commentController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                                borderSide: BorderSide(color: PrimaryColor),
                              ),
                              hintText: 'Enter your comment here...',
                              focusColor: PrimaryColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: PrimaryColor, width: 2),
                              ),
                            ),
                          ),
                          verticalSpacing(16),
                          Button(
                            text: 'Submit',
                            onTap: () {
                              final comment = commentController.text;
                              context
                                  .read<PlaceCubit>()
                                  .createReviewTourist(
                                  state.detailsopportunity.place!.id!,
                                  state.detailsopportunity.id!,
                                  rating,
                                  comment,context).then((v){
                                    commentController.clear();
                                    rating=0.0;
                              });
                            },
                          ),
                          SizedBox(
                            width: 170,
                            child: ElevatedButton(
                              onPressed: () {context.read<ApplicationCubit>().deleteApplication(
                                  state.detailsopportunity.id!, context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text('Delete',
                                  style: Styles.text16w600
                                      .copyWith(color: white)),
                            ),
                          ),
                        ],
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
      centerTitle: true,
      title: Text(
        'Vonture',
        style: Styles.textlogo.copyWith(fontSize: 45.sp, color: PrimaryColor),
      ),
      backgroundColor: white,
      shadowColor: white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: PrimaryColor,
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


Column displayRating(TouristReviews review) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${review.tourist?.firstName ?? ''}, ${review.tourist?.lastName ?? ''}',
        style: Styles.text18w400.copyWith(color: PrimaryColor),
      ),
      verticalSpacing(4),
      RatingBarIndicator(
        rating: review.rating!.toDouble() ?? 0,
        itemBuilder: (context, index) =>
        const Icon(
          Icons.star,
          color: PrimaryColor,
        ),
        itemCount: 5,
        itemSize: 20.0.sp,
        direction: Axis.horizontal,
      ),
      verticalSpacing(12),
      Text(
        review.comment ?? '',
        style: Styles.text18w400.copyWith(color: PrimaryColor),
      ),
      verticalSpacing(5),
      Divider(
        color: PrimaryColor,
        thickness: 0.5.sp,
        height: 2.h,
      ),
      verticalSpacing(20),
    ],
  );
}

class OpportunityAppBarwithreturn extends StatelessWidget
    implements PreferredSizeWidget {
  const OpportunityAppBarwithreturn({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        centerTitle: true,
        title: Text(
          'Vonture',
          style: Styles.textlogo.copyWith(
            fontSize: 45.sp,
          ),
        ),
        backgroundColor: PrimaryColor.withOpacity(0.99),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            final opportunityCubit = BlocProvider.of<OpportunityCubit>(context);
            opportunityCubit.getallopportunity().then((_) {
              Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/core/constants.dart/api_constants.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';
// import 'package:vonture_grad/core/constants.dart/styles.dart';
// import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/about_place.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/apply_button.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/meet_your_host.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_details_upper.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_location.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_offers.dart';
// import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_requirements.dart';

// class OpportunityDetails extends StatefulWidget {
//   const OpportunityDetails({super.key, required this.opportunityId});

//   final int opportunityId;

//   @override
//   _OpportunityDetailsState createState() => _OpportunityDetailsState();
// }

// class _OpportunityDetailsState extends State<OpportunityDetails> {
//   bool hasApplied = false;
//   List<int> touristApplications = [];

//   @override
//   void initState() {
//     super.initState();
//     checkIfApplied();
//   }

//   void checkIfApplied() {
//     final userTouristApplicationsBox = Hive.box(kTouristApplicationsBoxString);
//     touristApplications = (userTouristApplicationsBox
//                 .get(kTouristApplicationsBoxString) as List<dynamic>?)
//             ?.map((e) => e as int)
//             .toList() ??
//         [];

//     setState(() {
//       hasApplied = touristApplications.contains(widget.opportunityId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<OpportunityCubit>(context)
//         .getSpecifiOpportunity(widget.opportunityId);

//     return Scaffold(
//       appBar: const OpportunityAppBarwithreturn(),
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

//             setState(() {
//               hasApplied = true;
//               touristApplications.add(widget.opportunityId);
//             });

//             final userTouristApplicationsBox =
//                 Hive.box(kTouristApplicationsBoxString);
//             userTouristApplicationsBox.put(
//                 kTouristApplicationsBoxString, touristApplications);

//             BlocProvider.of<OpportunityCubit>(context)
//                 .getSpecifiOpportunity(widget.opportunityId);
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
//                   from: state.detailsopportunity.from ?? '',
//                   to: state.detailsopportunity.to ?? '',
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     children: [
//                       verticalSpacing(20),
//                       OpportunityOffers(
//                         offers: state.detailsopportunity.offers ?? [],
//                       ),
//                       verticalSpacing(20),
//                       OpportunityRequirements(
//                         requirements:
//                             state.detailsopportunity.requirements ?? [],
//                       ),
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
//                                     color: kLogoColor,
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             : ApplyButton(
//                                 onTap: () {
//                                   BlocProvider.of<OpportunityCubit>(context)
//                                       .applyOpportunity(widget.opportunityId);
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
// }

// class OpportunityAppBarwithreturn extends StatelessWidget
//     implements PreferredSizeWidget {
//   const OpportunityAppBarwithreturn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(
//         bottomLeft: Radius.circular(20),
//         bottomRight: Radius.circular(20),
//       ),
//       child: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Vonture',
//           style: Styles.textlogo.copyWith(
//             fontSize: 45.sp,
//           ),
//         ),
//         backgroundColor: PrimaryColor.withOpacity(0.99),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: white,
//           ),
//           onPressed: () {
//             final opportunityCubit = BlocProvider.of<OpportunityCubit>(context);
//             opportunityCubit.getallopportunity().then((_) {
//               Navigator.pop(context);
//             });
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
