// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';
// import 'package:vonture_grad/core/constants.dart/styles.dart';
// import 'package:vonture_grad/features/place/presentation/views/widgets/profile_image.dart';
// import 'package:vonture_grad/features/place/presentation/views/widgets/skills.dart';

// class TouristProfileBody extends StatelessWidget {
//   const TouristProfileBody(
//       {super.key,
//       required this.name,
//       required this.bio,
//       required this.natinonality,
//       required this.gender,
//       required this.birthdate,
//       required this.skills});
//   final String name;
//   final String bio;
//   final String natinonality;
//   final String gender;
//   final String birthdate;
//   final List<String> skills;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             verticalSpacing(10),
//             ProfileImage(),
//             verticalSpacing(16),
//             Text(name, style: Styles.text24w700.copyWith(fontSize: 26.sp)),
//             verticalSpacing(20),
//             Text(bio, style: Styles.text18w400.copyWith(color: PrimaryColor)),
//             const SizedBox(height: 16),
//             _buildProfileDetail(
//               icon: Icons.location_pin,
//               text: '$natinonality',
//             ),
//             _buildProfileDetail(
//               icon: Icons.date_range_outlined,
//               text: '$gender, born on  $birthdate',
//             ),
//             verticalSpacing(20),
//             Skills(skills: skills),
//             verticalSpacing(20),
//             const Text(
//               'Reviews',
//               style: TextStyle(
//                 color: Color(0xFF0C161C),
//                 fontSize: 22,
//                 fontFamily: 'Plus Jakarta Sans',
//                 fontWeight: FontWeight.w700,
//                 height: 1.2,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Jeanne, CA',
//               style: TextStyle(
//                 color: Color(0xFF0C161C),
//                 fontSize: 16,
//                 fontFamily: 'Plus Jakarta Sans',
//                 fontWeight: FontWeight.w500,
//                 height: 1.4,
//               ),
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               'Jan 2021',
//               style: TextStyle(
//                 color: Color(0xFF4C7C99),
//                 fontSize: 14,
//                 fontFamily: 'Plus Jakarta Sans',
//                 fontWeight: FontWeight.w400,
//                 height: 1.4,
//               ),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'Fantastic guest. Smooth and easy communication. Space was left tidy. Would high recommend.',
//               style: TextStyle(
//                 color: Color(0xFF0C161C),
//                 fontSize: 16,
//                 fontFamily: 'Plus Jakarta Sans',
//                 fontWeight: FontWeight.w400,
//                 height: 1.4,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileDetail({required IconData icon, required String text}) {
//     return SizedBox(
//       width: 390,
//       height: 56,
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: ShapeDecoration(
//               color: const Color(0xFFE8EFF2),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Icon(
//               icon,
//               color: PrimaryColor,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(text,
//                 style: Styles.text18w400.copyWith(
//                     decoration: TextDecoration.none, color: PrimaryColor)),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/place/data/models/profile%20_model/profile_model.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/profile_image.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/skills.dart';

class TouristProfileBody extends StatelessWidget {
  const TouristProfileBody({
    super.key,
    required this.name,
    required this.bio,
    required this.natinonality,
    required this.gender,
    required this.birthdate,
    required this.skills,
    required this.receivedReviews,
  });

  final String name;
  final String bio;
  final String natinonality;
  final String gender;
  final int birthdate;
  final List<String> skills;
  final List<ReceivedReviews> receivedReviews;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacing(10),
            ProfileImage(),
            verticalSpacing(16),
            Text(name, style: Styles.text24w700.copyWith(fontSize: 26.sp)),
            verticalSpacing(20),
            Text(bio, style: Styles.text18w400.copyWith(color: PrimaryColor)),
            const SizedBox(height: 16),
            _buildProfileDetail(
              icon: Icons.location_pin,
              text: natinonality,
            ),
            _buildProfileDetail(
              icon: Icons.date_range_outlined,
              text: '$gender, Age $birthdate',
            ),
            verticalSpacing(20),
            Skills(skills: skills),
            verticalSpacing(20),
            const Text(
              'Reviews',
              style: TextStyle(
                color: Color(0xFF0C161C),
                fontSize: 22,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            ...receivedReviews.map((review) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${review.givenBy?.firstName ?? ''}, ${review.givenBy?.lastName ?? ''}',
                      style: const TextStyle(
                        color: Color(0xFF0C161C),
                        fontSize: 16,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RatingBarIndicator(
                      rating: review.rating ?? 0,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: PrimaryColor,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      review.comment ?? '',
                      style: const TextStyle(
                        color: Color(0xFF0C161C),
                        fontSize: 16,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                )),
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
              onRatingUpdate: (rating) {
                print('Rating: $rating');
                // You can use this rating to send to your backend or state management
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: PrimaryColor),
                ),
                hintText: 'Enter your comment here...',
                focusColor: PrimaryColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: PrimaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print('Comment: ${_commentController.text}');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail({required IconData icon, required String text}) {
    return SizedBox(
      width: 390,
      height: 56,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              color: const Color(0xFFE8EFF2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Icon(
              icon,
              color: PrimaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: Styles.text18w400.copyWith(
                decoration: TextDecoration.none,
                color: PrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
