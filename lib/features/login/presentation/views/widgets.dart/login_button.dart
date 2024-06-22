import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/core/utils/app_router.dart';
import 'package:vonture_grad/features/login/presentation/managers/cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.go(AppRouter.kHome);
        } else if (state is LoginFailure) {
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
              backgroundColor: PrimaryColor,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: white,
              color: PrimaryColor,
            ),
          );
        } else {
          return GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 378,
                height: 47,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: ShapeDecoration(
                  color: const Color(0xFF002F44),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0x7F5B5B5B)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Sign in',
                        textAlign: TextAlign.center,
                        style: Styles.text16w600.copyWith(color: white)),
                  ],
                ),
              ));
        }
      },
    );
  }
}
