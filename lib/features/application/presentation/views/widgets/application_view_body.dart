import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/application/presentation/views/widgets/application_card.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/opportunity_details_view.dart';

class ApplicationViewBody extends StatefulWidget {
  const ApplicationViewBody({super.key});

  @override
  _ApplicationViewBodyState createState() => _ApplicationViewBodyState();
}

class _ApplicationViewBodyState extends State<ApplicationViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<ApplicationCubit>().getMyApplications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicationCubit, ApplicationState>(
        builder: (context, state) {
      if (state is ApplicationLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: PrimaryColor,
          ),
        );
      } else if (state is ApplicationSuccess) {
        if (state.applications.isEmpty) {
          return const Center(
            child: Text('No opportunities found'),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: state.applications.length,
            itemBuilder: (context, index) {
              final application = state.applications[index];
              Widget? additionalWidget;

              if (application.status == 'PENDING') {
                additionalWidget = ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor,
                  ),
                  onPressed: () {
                    ApplicationCubit.get(context)
                        .getPayment(application.opportunity!.id!);
                  },
                  child: const Text(
                    'Pay',
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => OpportunityDetails(
                                opportunityId:
                                    state.applications[index].opportunity!.id!,
                                isApllication: true,
                              )));
                },
                child: ApplicationCard(
                  title: application.opportunity?.title ?? ' ',
                  dateRange: '${application.opportunity?.from ?? ' '}'
                      ' - ${application.opportunity?.to ?? ' '}',
                  status: application.status ?? '',
                  imageUrl: application.opportunity!.place!.placeMedia!.isEmpty
                      ? 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'
                      : application.opportunity!.place!.placeMedia!.first,
                  additionalWidget: additionalWidget,
                ),
              );
            },
          );
        }
      } else if (state is ApplicationError) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: PrimaryColor,
          ),
        );
      }
    }, listener: (BuildContext context, ApplicationState state) async {
      if (state is PaymentLoading) {
        print("Loading");
      } else if (state is PaymentSuccess) {
        print(state.url);
        !await launchUrl(Uri.parse(state.url));
        ApplicationCubit.get(context).getMyApplications();
      } else if (state is PaymentError) {
        print(state.message);
      }
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';
// import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
// import 'package:vonture_grad/features/application/presentation/views/widgets/application_card.dart';

// class ApplicationViewBody extends StatelessWidget {
//   const ApplicationViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ApplicationCubit, ApplicationState>(
//       builder: (context, state) {
//         if (state is ApplicationLoading) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is ApplicationSuccess) {
//           if (state.applications.isEmpty) {
//             return const Center(
//               child: Text('No opportunities found'),
//             );
//           } else {
//             return ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               shrinkWrap: true,
//               itemCount: state.applications.length,
//               itemBuilder: (context, index) {
//                 final application = state.applications[index];
//                 Widget? additionalWidget;

//                 if (application.status == 'PENDING') {
//                   additionalWidget = ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: kPrimaryColor,
//                     ),
//                     onPressed: () {},
//                     child: const Text(
//                       'Pay',
//                       style: TextStyle(
//                         color: Color(0xff8C6B59),
//                       ),
//                     ),
//                   );
//                 }

//                 return ApplicationCard(
//                   title: application.opportunity?.title ?? ' ',
//                   dateRange: '${application.opportunity?.from ?? ' '}'
//                       ' - ${application.opportunity?.to ?? ' '}',
//                   status: application.status ?? '',
//                   imageUrl: 'assets/shelter.jpg',
//                   additionalWidget: additionalWidget,
//                 );
//               },
//             );
//           }
//         } else if (state is ApplicationError) {
//           return Center(
//             child: Text(state.message),
//           );
//         } else {
//           return Center(
//             child: Text('Unknown state: $state'),
//           );
//         }
//       },
//     );
//   }
// }
