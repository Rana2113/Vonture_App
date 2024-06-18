import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

class OpportunityOffers extends StatelessWidget {
  const OpportunityOffers({super.key, required this.offers});

  final List<String> offers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Offers',
          style: TextStyle(
            color: kLogoColor,
            fontSize: 22.sp,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpacing(10),
        ...offers.map((offer) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(
                      color: Color(0xFF161111),
                      fontSize: 16,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      offer,
                      style: const TextStyle(
                        color: Color(0xFF161111),
                        fontSize: 16,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';

// class OpportunityOffers extends StatelessWidget {
//   const OpportunityOffers({super.key, required this.offers});
//   final String offers;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Offers',
//           style: TextStyle(
//             color: kLogoColor,
//             fontSize: 22.sp,
//             fontFamily: 'Work Sans',
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         verticalSpacing(10),
//         Row(
//           children: [
//             const Text(
//               '• ',
//               style: TextStyle(
//                 color: Color(0xFF161111),
//                 fontSize: 16,
//                 fontFamily: 'Work Sans',
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             Flexible(
//               child: Text(
//                 offers,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: const TextStyle(
//                   color: Color(0xFF161111),
//                   fontSize: 16,
//                   fontFamily: 'Work Sans',
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         verticalSpacing(10),
//         Text(
//           'Requirements',
//           style: TextStyle(
//             color: kLogoColor,
//             fontSize: 22.sp,
//             fontFamily: 'Work Sans',
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         verticalSpacing(10),
//         const SizedBox(height: 15),
//       ],
//     );
//   }
// }
// //  const Row(
// //           children: [
// //             Text(
// //               '•  ',
// //               style: TextStyle(
// //                 color: Color(0xFF161111),
// //                 fontSize: 16,
// //                 fontFamily: 'Work Sans',
// //                 fontWeight: FontWeight.w400,
// //               ),
// //             ),
// //             Flexible(
// //               child: Text(
// //                 requi,
// //                 overflow: TextOverflow.ellipsis,
// //                 maxLines: 1,
// //                 style: TextStyle(
// //                   color: Color(0xFF161111),
// //                   fontSize: 16,
// //                   fontFamily: 'Work Sans',
// //                   fontWeight: FontWeight.w400,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),