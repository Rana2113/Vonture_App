import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';

class MyOpportunityCard extends StatelessWidget {
  const MyOpportunityCard({
    Key? key,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.id,
    required this.status,
  }) : super(key: key);

  final String title;
  final String description;
  final String from;
  final String to;
  final int id;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/siwa.jpg',
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff8C6B59),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8C6B59),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Available From $from To $to',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8C6B59),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocConsumer<PlaceCubit, PlaceState>(
                listener: (context, state) {
                  if (state is CloseOpportunityError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  } else if (state is CloseOpportunity) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  IconData icon = FontAwesomeIcons.lockOpen;
                  bool isLoading = state is CloseOpportunityLoading;
                  bool isClosed = status == 'CLOSED';

                  if (isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (isClosed) {
                    icon = FontAwesomeIcons.lock;
                  }

                  return ElevatedButton.icon(
                    onPressed: isClosed || isLoading
                        ? null
                        : () {
                            context.read<PlaceCubit>().closeOpportunity(id);
                          },
                    icon: Icon(
                      icon,
                      color: Colors.white,
                    ),
                    label: Text(
                      isClosed ? 'Closed Opportunity' : 'Close Opportunity',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isClosed ? Colors.grey : kLogoColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';

// class MyOpportunityCard extends StatelessWidget {
//   const MyOpportunityCard(
//       {super.key,
//       required this.title,
//       required this.description,
//       required this.from,
//       required this.onTap,
//       required this.to,
//       this.icon});
//   final String title;
//   final String description;
//   final String from;
//   final String to;
//   final IconData? icon;

//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: 16.h,
//         left: 16.w,
//         right: 16.w,
//       ),
//       child: Card(
//         color: kCardColor,
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12.0),
//               child: Image.asset(
//                 'assets/siwa.jpg',
//                 height: 200.h,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             verticalSpacing(10),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w800,
//                   color: const Color(0xff8C6B59),
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             verticalSpacing(6),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Text(
//                 description,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w400,
//                   color: const Color(0xff8C6B59),
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             verticalSpacing(10),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Text(
//                 'Available From $from To $to',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   color: const Color(0xff8C6B59),
//                 ),
//               ),
//             ),
//             verticalSpacing(10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(children: [
//                 const Spacer(
//                   flex: 1,
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: onTap,
//                   label: Icon(icon, color: kCardColor),
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all<Color>(kLogoColor),
//                   ),
//                 ),
//               ]),
//             ),
//             verticalSpacing(20),
//           ],
//         ),
//       ),
//     );
//   }
// }
