import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';

class AddPlaceButton extends StatelessWidget {
  final void Function() onPressed;

  const AddPlaceButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaceCubit, PlaceState>(
      listener: (context, state) {
        if (state is PlaceCreateSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Place added successfully'),
              backgroundColor: PrimaryColor,
            ),
          );
          Navigator.of(context).pop();
          final userId = Hive.box(kidBoxString).get(kidBoxString);
          context.read<PlaceCubit>().getmyplace(userId);
        } else if (state is PlaceCreateErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PlaceCreateLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: PrimaryColor,
            ),
          );
        } else {
          return ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200.w, 48.h),
                backgroundColor: PrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
              ),
              child: Text(
                'Add Place',
                style: Styles.text16w500.copyWith(color: white),
              ));
        }
      },
    );
  }
}
