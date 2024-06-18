import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
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
              content: Text(state.message),
              backgroundColor: kButtonColor,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: kButtonColor,
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sign in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFCFCFC),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0.10,
                      ),
                    ),
                  ],
                ),
              ));
        }
      },
    );
  }
}
