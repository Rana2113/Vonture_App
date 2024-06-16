import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/application/presentation/views/widgets/application_card.dart';

class ApplicationViewBody extends StatefulWidget {
  const ApplicationViewBody({super.key});

  @override
  _ApplicationViewBodyState createState() => _ApplicationViewBodyState();
}

class _ApplicationViewBodyState extends State<ApplicationViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<ApplicationCubit>().getallopportunity();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        if (state is ApplicationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
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
                      backgroundColor: kPrimaryColor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Pay',
                      style: TextStyle(
                        color: Color(0xff8C6B59),
                      ),
                    ),
                  );
                }

                return ApplicationCard(
                  title: application.opportunity?.title ?? ' ',
                  dateRange: '${application.opportunity?.from ?? ' '}'
                      ' - ${application.opportunity?.to ?? ' '}',
                  status: application.status ?? '',
                  imageUrl: 'assets/shelter.jpg',
                  additionalWidget: additionalWidget,
                );
              },
            );
          }
        } else if (state is ApplicationError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text('Unknown state: $state'),
          );
        }
      },
    );
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
