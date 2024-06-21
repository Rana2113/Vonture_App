import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vonture_grad/core/utils/service_locator.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';

import '../../../../core/components/spacing.dart';
import '../../../../core/constants.dart/api_constants.dart';
import '../../../../core/constants.dart/colors.dart';
import '../../../../core/constants.dart/styles.dart';
import '../../../place/data/models/profile _model/profile_model.dart';
import '../../../place/data/place_repo_implementation.dart';
import '../../../place/presentation/views/add_opportunity_view.dart';
import '../../../place/presentation/views/widgets/profile_image.dart';
import '../../../place/presentation/views/widgets/skills.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;

  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) =>
              PlaceCubit(getIt<PlaceRepoImplementation>())..getUserData(),
          child: BlocConsumer<PlaceCubit, PlaceState>(
              listener: (context, state) async{
                if(state is SubscriptionSuccess){
                  print("////////////////");
                  print(state.url);
                  !await launchUrl(Uri.parse(state.url));
                }
              },
              builder: (context, state) {
                if (state is GetOtherProfileSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        verticalSpacing(10),
                        Stack(
                          children: [
                            Container(
                              width: 140.w,
                              height: 140.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: _image == null
                                      ? state.application.profileImg != null
                                          ? NetworkImage(state
                                              .application.profileImg
                                              .toString())
                                          : const AssetImage(
                                              'assets/avatar.png')
                                      : FileImage(_image!),
                                  fit: BoxFit.cover,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(77),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: -5,
                                right: -5,
                                child: IconButton(
                                    onPressed: () {
                                      _openImagePicker();
                                    },
                                    icon: const Icon(
                                      Icons.camera,
                                      size: 35,
                                      color: Colors.blue,
                                    )))
                          ],
                        ),
                        verticalSpacing(16),
                        Text(state.application.firstName.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 30)),
                        verticalSpacing(20),
                        Text(state.application.bio.toString(),
                            style: TextStyle(color: Colors.black)),
                        const SizedBox(height: 16),
                        _buildProfileDetail(
                          icon: Icons.location_pin,
                          text: state.application.nationality!,
                        ),
                        _buildProfileDetail(
                          icon: Icons.date_range_outlined,
                          text:
                              '${state.application.gender}, Age ${state.application.age}',
                        ),
                        verticalSpacing(20),
                        Skills(skills: state.application.skills ?? []),
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
                        ...(state.application.receivedReviews ?? [])
                            .map((review) => displayRating(review)),
                      ],
                    ),
                  );
                } else if (state is GetOtherProfileLoading||state is SubscriptionLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetOtherProfileError) {
                  return const Center(
                    child: Text("there is error"),
                  );
                } else {
                  return Text("data");
                }
              }),
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
        Center(
          child: SizedBox(
            width: 250,
            child: ElevatedButton(
                onPressed: () {
                  PlaceCubit.get(context).uploadProfile(_image!.path, context);
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue)),
                child: const Center(
                  child: Text(
                    "Upload",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          ),
        ),
        Center(
          child: SizedBox(
            width: 250,
            child: ElevatedButton(
                onPressed: () {
                  PlaceCubit.get(context).getSubscription().then((val)async{

                    print("this is $val");
                    await launchUrl(Uri.parse(val));

                  });
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue)),
                child: const Center(
                  child: Text(
                    "Subscription",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          ),
        ),

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
