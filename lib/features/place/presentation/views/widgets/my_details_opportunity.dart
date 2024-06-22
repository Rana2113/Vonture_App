import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/application/presentation/views/get_all_application_opportunity.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_description.dart';
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
      appBar: AppBarwithreturn(
        placeId: widget.placeId,
      ),
      body: BlocConsumer<OpportunityCubit, OpportunityState>(
        listener: (context, state) {
          if (state is CloseOpportunity) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Closed successfully!'),
                  duration: Duration(milliseconds: 1),
                ),
              );

            BlocProvider.of<OpportunityCubit>(context)
                .getSpecifiOpportunity(widget.opportunityId);
          }
        },
        builder: (context, state) {
          if (state is GetSpecifiOpportunityLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: PrimaryColor,
              ),
            );
          } else if (state is GetSpecifiOpportunitySuccess ||
              state is CloseOpportunity) {
            final opportunity = (state is GetSpecifiOpportunitySuccess)
                ? state.detailsopportunity
                : (state as CloseOpportunity).closeOpportunity;
            return ListView(
              children: [
                OpportunityDetailsUpper(
                  image: opportunity.place!.placeMedia!.isEmpty
                      ? [
                          'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
                          'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'
                        ]
                      : opportunity.place!.placeMedia!,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(20),
                      OpportunityDescription(
                        title: opportunity.title ?? ' ',
                        from: opportunity.from ?? '',
                        to: opportunity.to ?? '',
                        description: opportunity.description ?? '',
                      ),
                      verticalSpacing(25),
                      OpportunityOffers(
                        offers: opportunity.offers ?? [],
                      ),
                      verticalSpacing(25),
                      OpportunityRequirements(
                        requirements: opportunity.requirements ?? [],
                      ),
                      verticalSpacing(25),
                      OpportunityLocation(
                        country: opportunity.place?.country ?? '',
                        city: opportunity.place?.city ?? ' ',
                        pin: opportunity.place?.pin ?? ' ',
                      ),
                      verticalSpacing(20),
                      Row(
                        children: [
                          Button(
                              text: 'See Applications',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GetAllApplicationOpportunity(
                                              opportunityId: opportunity.id!,
                                            )));
                              }),
                          const Spacer(
                            flex: 1,
                          ),
                          if (opportunity.status == 'CLOSED')
                            Center(
                              child: SizedBox(
                                width: 170,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: white,
                                      side: const BorderSide(
                                        color: PrimaryColor,
                                        width: 1,
                                      )),
                                  child: Icon(
                                    Icons.lock,
                                    color: PrimaryColor,
                                    size: 30.sp,
                                  ),
                                ),
                              ),
                            )
                          else
                            Button(
                              onTap: () {
                                BlocProvider.of<OpportunityCubit>(context)
                                    .closeOpportunity(widget.opportunityId);
                              },
                              text: 'Close',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: PrimaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, this.onTap, required this.text});
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 170,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: PrimaryColor,
            shadowColor: white,
          ),
          child: Text(text, style: Styles.text14w600.copyWith(fontSize: 13)),
        ),
      ),
    );
  }
}

class AppBarwithreturn extends StatelessWidget implements PreferredSizeWidget {
  const AppBarwithreturn({super.key, required this.placeId});
  final int placeId;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Vonture',
        style: Styles.textlogo.copyWith(
          fontSize: 45.sp,
          color: PrimaryColor,
        ),
      ),
      elevation: 0,
      bottomOpacity: 0.0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: PrimaryColor,
        ),
        onPressed: () {
          final placeCubit = BlocProvider.of<PlaceCubit>(context);
          Navigator.of(context).pop();

          placeCubit.getallplaceopportunity(placeId);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// AppBar _buildAppBar(BuildContext context) {
  //   return AppBar(
  //     title: SizedBox(
  //       height: 50.h,
  //       width: 120.w,
  //       child: const Text(
  //         'Vonture',
  //         style: Styles.textlogo,
  //       ),
  //     ),
  //     centerTitle: true,
  //     leading: IconButton(
  //       icon: const Icon(
  //         Icons.arrow_back,
  //         color: kPrimaryColor,
  //       ),
  //       onPressed: () {
  //         final placeCubit = BlocProvider.of<PlaceCubit>(context);
  //         placeCubit.getallplaceopportunity(widget.placeId).then((_) {
  //           Navigator.pop(context);
  //         });
  //       },
  //     ),
  //   );
  // }