import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/place/data/models/profile%20_model/profile_model.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/my_details_opportunity.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/profile_image.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/skills.dart';

class TouristProfileBody extends StatefulWidget {
  const TouristProfileBody({
    super.key,
    required this.name,
    required this.bio,
    required this.natinonality,
    required this.gender,
    required this.birthdate,
    required this.skills,
    required this.receivedReviews,
    required this.touristid,
    required this.opportunityId,
    required this.status,
  });

  final String name;
  final String bio;
  final String natinonality;
  final String gender;
  final int birthdate;
  final List<String>? skills;
  final List<ReceivedReviews>? receivedReviews;
  final int touristid;
  final int opportunityId;
  final String? status;

  @override
  State<TouristProfileBody> createState() => _TouristProfileBodyState();
}

class _TouristProfileBodyState extends State<TouristProfileBody> {
  final TextEditingController commentController = TextEditingController();
  double rating = 0.0;
  bool applicationProcessing = false;

  @override
  void initState() {
    print(widget.status!);
    if (widget.status == "APPLIED") {

        applicationProcessing = false;

    } else {
      applicationProcessing = true;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacing(10),
            const ProfileImage(),
            verticalSpacing(16),
            Text(widget.name,
                style: Styles.text24w700.copyWith(fontSize: 26.sp)),
            verticalSpacing(20),
            Text(widget.bio,
                style: Styles.text18w400.copyWith(color: PrimaryColor)),
            const SizedBox(height: 16),
            _buildProfileDetail(
              icon: Icons.location_pin,
              text: widget.natinonality,
            ),
            _buildProfileDetail(
              icon: Icons.date_range_outlined,
              text: '${widget.gender}, Age ${widget.birthdate}',
            ),
            verticalSpacing(20),
            Skills(skills: widget.skills ?? []),
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
            ...(widget.receivedReviews ?? [])
                .map((review) => displayRating(review)),



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
                setState(() {
                  rating = newRating;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: commentController,
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
            verticalSpacing(16),
            Button(
              text: 'Submit',
              onTap: () {
                final comment = commentController.text;
                context
                    .read<PlaceCubit>()
                    .createreview(widget.touristid, rating, comment);
              },
            ),
            if (applicationProcessing == false)
              Row(
                children: [
                  Button(
                    text: 'Accept',
                    onTap: () {
                      context
                          .read<PlaceCubit>()
                          .acceptedApplication(
                              widget.opportunityId, widget.touristid);


                    },
                  ),
                  const Spacer(),
                  Button(
                    text: 'Reject',
                    onTap: () {
                      context
                          .read<PlaceCubit>()
                          .rejectApplication(
                              widget.opportunityId, widget.touristid)
                         ;
                    },
                  ),
                ],
              ),
            if (applicationProcessing == true)
              Center(
                child: Text(
                    'You have already ${widget.status!.toLowerCase()} this tourist'),
              ),
          ],
        ),
      ),
    );
  }

  Column displayRating(ReceivedReviews review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${review.givenBy?.firstName ?? ''}, ${review.givenBy?.lastName ?? ''}',
          style: Styles.text18w400.copyWith(color: PrimaryColor),
        ),
        verticalSpacing(4),
        RatingBarIndicator(
          rating: review.rating ?? 0,
          itemBuilder: (context, index) => const Icon(
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

  Widget _buildProfileDetail({required IconData icon, required String text}) {
    return SizedBox(
      width: 390.w,
      height: 56.h,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
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
          horizontalSpacing(10),
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
