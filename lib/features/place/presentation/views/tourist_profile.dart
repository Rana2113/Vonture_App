import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/tourist_profile_body.dart';

class TouristProfile extends StatefulWidget {
  const TouristProfile({
    super.key,
    required this.touristid,
    required this.opportunityId,
    required this.status,
  });

  final int touristid;
  final int opportunityId;
  final String status;

  @override
  State<TouristProfile> createState() => _TouristProfileState();
}

class _TouristProfileState extends State<TouristProfile> {
  String currentStatus = "";

  @override
  void initState() {
    super.initState();
    currentStatus = widget.status;
    context
        .read<PlaceCubit>()
        .getotherprofile(widget.touristid, widget.opportunityId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarwithReturn(
        opportunityId: widget.opportunityId,
        onStatusUpdated: (String newStatus) {
          currentStatus = newStatus;
        },
      ),
      body: BlocListener<PlaceCubit, PlaceState>(
        listener: (context, state) {
          if (state is CreateReviewSuccess) {
            context
                .read<PlaceCubit>()
                .getotherprofile(widget.touristid, widget.opportunityId);
          } else if (state is CreateReviewError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: error,
                content: Text(state.message),
                duration: const Duration(seconds: 5),
              ),
            );
            context
                .read<PlaceCubit>()
                .getotherprofile(widget.touristid, widget.opportunityId);
          } else if (state is GetOtherProfileError) {
            const Center(
              child: CircularProgressIndicator(
                color: PrimaryColor,
              ),
            );
          } else if (state is AcceptApplicationSuccess ||
              state is AcceptApplicationError ||
              state is RejectApplicationSuccess ||
              state is RejectApplicationError) {
            context
                .read<PlaceCubit>()
                .getotherprofile(widget.touristid, widget.opportunityId);
          }
        },
        child: BlocBuilder<PlaceCubit, PlaceState>(
          builder: (context, state) {
            if (state is GetOtherProfileSuccess) {
              final tourist = state.application;
              return TouristProfileBody(
                bio: tourist.bio!,
                name: '${tourist.firstName} ${tourist.lastName}',
                gender: tourist.gender!,
                birthdate: tourist.age!,
                skills: tourist.skills?.cast<String>() ?? [],
                natinonality: tourist.nationality ?? '',
                receivedReviews: tourist.receivedReviews ?? [],
                touristid: tourist.id!,
                opportunityId: widget.opportunityId,
                status: tourist.status,
              );
            } else if (state is GetOtherProfileError) {
              const Center(
                child: CircularProgressIndicator(
                  color: PrimaryColor,
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: PrimaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppBarwithReturn extends StatelessWidget implements PreferredSizeWidget {
  const AppBarwithReturn({
    super.key,
    required this.opportunityId,
    required this.onStatusUpdated,
  });

  final int opportunityId;
  final void Function(String newStatus) onStatusUpdated;

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
          style: Styles.textlogo.copyWith(
            fontSize: 45.sp,
            color: PrimaryColor,
          ),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: PrimaryColor,
          ),
          onPressed: () {
            final applicationCubit = BlocProvider.of<ApplicationCubit>(context);
            Navigator.of(context).pop();
            applicationCubit
                .getallapplicationopportunity(opportunityId)
                .then((_) {
              onStatusUpdated("Updated Status");
            });
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
