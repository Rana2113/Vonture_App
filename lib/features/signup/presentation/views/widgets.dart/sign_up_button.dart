import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/core/utils/app_router.dart';
import 'package:vonture_grad/features/signup/presentation/managers/cubit/sign_up_cubit.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          context.go(AppRouter.kHome);
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Text(
                state.message,
                style: Styles.text16w500.copyWith(color: white),
              ),
              duration: const Duration(seconds: 5),
              backgroundColor: error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SignUpLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: PrimaryColor,
            ),
          );
        } else {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: PrimaryColor,
                  ),
                  width: double.infinity,
                  height: 48.h,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      child: Text('Sign Up',
                          style: Styles.text16w600.copyWith(color: white)),
                    ),
                  ),
                ),
              ));
        }
      },
    );
  }
}
