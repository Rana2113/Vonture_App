import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/utils/service_locator.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/app_bar.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/my_details_opportunity.dart';

import '../../../../core/components/spacing.dart';
import '../../../../core/constants.dart/colors.dart';
import '../../../../core/constants.dart/styles.dart';
import '../../../place/data/models/profile _model/profile_model.dart';
import '../../../place/data/place_repo_implementation.dart';
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
    final userRoleBox = Hive.box(kRoleBoxString);
    String? role = userRoleBox.get(kRoleBoxString);
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: BlocProvider(
          create: (context) =>
              PlaceCubit(getIt<PlaceRepoImplementation>())..getUserData(),
          child: BlocConsumer<PlaceCubit, PlaceState>(
              listener: (context, state) async {
            if (state is SubscriptionLoading) {
              print("Loading");
            } else if (state is SubscriptionSuccess) {
              print(state.url);
              !await launchUrl(Uri.parse(state.url));
              PlaceCubit.get(context).getUserData();
            } else if (state is SubscriptionError) {
              print(state.message);
            }
          }, builder: (context, state) {
            if (state is GetOtherProfileSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(10),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: _image == null
                                      ? state.application.profileImg != null
                                          ? NetworkImage(
                                              state.application.profileImg!)
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
                                bottom: -1,
                                right: 3,
                                child: IconButton(
                                    onPressed: () {
                                      _openImagePicker();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 35,
                                      color: PrimaryColor,
                                    )))
                          ],
                        ),
                      ),
                      verticalSpacing(16),
                      Text(
                          '${state.application.firstName!} ${state.application.lastName!}',
                          style: Styles.text24w700.copyWith(fontSize: 26.sp)),
                      verticalSpacing(29),
                      Text(state.application.bio.toString(),
                          style: Styles.text18w400
                              .copyWith(color: PrimaryColor, height: 1)),
                      verticalSpacing(26),
                      _buildProfileDetail(
                        icon: Icons.mail,
                        text: '${state.application.email}',
                      ),
                      _buildProfileDetail(
                        icon: Icons.location_pin,
                        text: state.application.nationality!,
                      ),
                      _buildProfileDetail(
                        icon: Icons.date_range_outlined,
                        text:
                            '${state.application.gender}, Age ${state.application.age}',
                      ),
                      // _buildProfileDetail(
                      //   icon: Icons.mail,
                      //   text: '${state.application.email}',
                      // ),
                      if (role == 'TOURIST')
                        Column(
                          children: [
                            verticalSpacing(55),
                            Skills(skills: state.application.skills ?? []),
                          ],
                        )
                      else
                        Container(),
                      verticalSpacing(55),
                      Text('Reviews',
                          style: Styles.text24w700.copyWith(
                              fontSize: 26, fontWeight: FontWeight.w600)),
                      verticalSpacing(30),
                      ...(state.application.receivedReviews ?? [])
                          .map((review) => displayRating(review)),
                      verticalSpacing(20),
                      if (role == 'TOURIST')
                        Row(
                          children: [
                            Button(
                              text: 'Upload',
                              onTap: () {
                                PlaceCubit.get(context)
                                    .uploadProfile(_image!.path, context);
                              },
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Button(
                              text: 'Subscription',
                              onTap: () {
                                PlaceCubit.get(context)
                                    .getSubscription()
                                    .then((val) async {
                                  print("this is $val");
                                  await launchUrl(Uri.parse(val));
                                });
                              },
                            )
                          ],
                        )
                      else
                        Center(
                          child: Button(
                            text: 'Upload',
                            onTap: () {
                              PlaceCubit.get(context)
                                  .uploadProfile(_image!.path, context);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              );
            } else if (state is GetOtherProfileLoading ||
                state is SubscriptionLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: PrimaryColor,
                ),
              );
            } else if (state is GetOtherProfileError) {
              return const Center(
                child: Text("there is error"),
              );
            } else {
              return Center(child: Text("Payment loading"));
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
        verticalSpacing(10),
        Text(
          '${review.givenBy?.firstName ?? ''} ${review.givenBy?.lastName ?? ''}',
          style: Styles.text18w400.copyWith(color: PrimaryColor),
        ),
        verticalSpacing(10),
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
        // Divider(
        //   color: PrimaryColor,
        //   thickness: 0.5.sp,
        //   height: 2.h,
        // ),
        verticalSpacing(20),
        // Center(
        //   child: SizedBox(
        //     width: 250,
        //     child: ElevatedButton(
        //         onPressed: () {
        //           PlaceCubit.get(context).uploadProfile(_image!.path, context);
        //         },
        //         style: ButtonStyle(
        //             backgroundColor: WidgetStateProperty.all(Colors.blue)),
        //         child: const Center(
        //           child: Text(
        //             "Upload",
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //         )),
        //   ),
        // ),
        // Center(
        //   child: SizedBox(
        //     width: 250,
        //     child: ElevatedButton(
        //         onPressed: () {
        //           PlaceCubit.get(context).getSubscription().then((val) async {
        //             print("this is $val");
        //             await launchUrl(Uri.parse(val));
        //           });
        //         },
        //         style: ButtonStyle(
        //             backgroundColor: WidgetStateProperty.all(Colors.blue)),
        //         child: const Center(
        //           child: Text(
        //             "Subscription",
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //         )),
        //   ),
        // ),
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
// Row(
//                         children: [
//                           Button(
//                               text: 'See Applications',
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             GetAllApplicationOpportunity(
//                                               opportunityId: opportunity.id!,
//                                             )));
//                               }),
//                           const Spacer(
//                             flex: 1,
//                           ),
//                           if (opportunity.status == 'CLOSED')
//                             Center(
//                               child: SizedBox(
//                                 width: 170,
//                                 child: ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                       backgroundColor: white,
//                                       side: const BorderSide(
//                                         color: PrimaryColor,
//                                         width: 1,
//                                       )),
//                                   child: Icon(
//                                     Icons.lock,
//                                     color: PrimaryColor,
//                                     size: 30.sp,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           else
//                             Button(
//                               onTap: () {
//                                 BlocProvider.of<OpportunityCubit>(context)
//                                     .closeOpportunity(widget.opportunityId);
//                               },
//                               text: 'Close',
//                             ),
//                         ],
//                       ),








//  Row(
//                                   children: [
//                                     Button(
//                                       text: 'Upload',
//                                        onTap: () {
//                               PlaceCubit.get(context)
//                                   .getSubscription()
//                                   .then((val) async {
//                                 print("this is $val");
//                                 await launchUrl(Uri.parse(val));
//                               });
//                             },
//                                     ),
//                                     const Spacer(
//                                       flex: 1,
//                                     ),
//                                    Button(
//                                       text: 'subuscription',
//                                       onTap: () 
//                                     {
//                               PlaceCubit.get(context)
//                                   .uploadProfile(_image!.path, context);
                            
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],