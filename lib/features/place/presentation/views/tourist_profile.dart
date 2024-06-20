import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/tourist_profile_body.dart';

class TouristProfile extends StatefulWidget {
  const TouristProfile({Key? key, required this.touristid}) : super(key: key);
  final int touristid;

  @override
  State<TouristProfile> createState() => _TouristProfileState();
}

class _TouristProfileState extends State<TouristProfile> {
  @override
  void initState() {
    super.initState();
    context.read<PlaceCubit>().getotherprofile(widget.touristid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarwithReturn(),
      body: BlocBuilder<PlaceCubit, PlaceState>(
        builder: (context, state) {
          if (state is GetOtherProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: PrimaryColor,
              ),
            );
          } else if (state is GetOtherProfileSuccess) {
            print('TouristProfileSuccess: ${state.application.toJson()}');
            final tourist = state.application;
            return ListView(
              children: [
                TouristProfileBody(
                  bio: tourist.bio!,
                  name: '${tourist.firstName} ${tourist.lastName}',
                  gender: tourist.gender!.toLowerCase(),
                  birthdate: tourist.age!,
                  skills: tourist.skills?.cast<String>() ?? [],
                  natinonality: tourist.nationality ?? '',
                  receivedReviews: tourist.receivedReviews ?? [],
                ),
              ],
            );
          } else if (state is GetOtherProfileError) {
            print('TouristProfileError: ${state.message}');
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: PrimaryColor,
            ),
          );
        },
      ),
    );
  }
}

class AppBarwithReturn extends StatelessWidget implements PreferredSizeWidget {
  const AppBarwithReturn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      child: AppBar(
        centerTitle: true,
        title: Text(
          'Vonture',
          style: Styles.textlogo.copyWith(fontSize: 45.sp, color: PrimaryColor),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: PrimaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
