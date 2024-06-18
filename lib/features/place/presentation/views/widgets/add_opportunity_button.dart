import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/my-opportunity_view.dart';

class AddOpportunityButton extends StatelessWidget {
  final void Function() onPressed;
  final int placeId;

  const AddOpportunityButton(
      {super.key, required this.onPressed, required this.placeId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaceCubit, PlaceState>(
      listener: (context, state) {
        if (state is CreateOpportunitySucessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Place added successfully'),
              backgroundColor: kButtonColor,
            ),
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyOpportunityView(
                placeId: placeId,
              ),
            ),
          );
          context.read<PlaceCubit>().getallplaceopportunity(placeId);
        } else if (state is CreateOpportunityErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: kButtonColor,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CreateOpportunityLoadingState ||
            state is GetAllPlaceOpportunityLoadingState) {
          return const CircularProgressIndicator(
            color: PrimaryColor,
          );
        }
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(200.w, 48.h),
            backgroundColor: kButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
          child: const Text('Add Place'),
        );
      },
    );
  }
}
