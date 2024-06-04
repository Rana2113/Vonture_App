import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/app_bar.dart';
import 'package:vonture_grad/core/components/button.dart';
import 'package:vonture_grad/core/components/image.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/components/text_field.dart';
import 'package:vonture_grad/core/utils/service_locator.dart';
import 'package:vonture_grad/features/login/data/login_repo_implementation.dart';
import 'package:vonture_grad/features/login/presentation/managers/cubit/login_cubit.dart';
import 'package:vonture_grad/features/login/presentation/views/widgets.dart/login_button.dart';
import 'package:vonture_grad/features/signup/presentation/views/signup_view.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
        create: (context) => LoginCubit(getIt<LoginRepoImplementation>()),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomAppBar(text: 'Sign In'),
                    verticalSpacing(10),
                    const CustomImage(image: 'assets/signin.png'),
                    verticalSpacing(44),
                    AppTextField(
                      hinttext: 'Email',
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                    ),
                    verticalSpacing(24),
                    AppTextField(
                      hinttext: 'Password',
                      controller: passwordController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      isPassword: LoginCubit.get(context).isPasswordVisible,
                      suffixIcon: IconButton(
                          onPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          icon: Icon(
                            state is ChangePasswordVisibility &&
                                    state.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          )),
                      type: TextInputType.visiblePassword,
                    ),
                    verticalSpacing(44),
                    LoginButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    ),
                    verticalSpacing(16),
                    SizedBox(
                      width: 386.w,
                      height: 42.h,
                      child: Text(
                        textAlign: TextAlign.center,
                        'By signing in, you agree to our Terms of Service and Privacy Policy',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xff877563),
                          // height: 0.42.sp,
                        ),
                      ),
                    ),
                    verticalSpacing(44),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: SizedBox(
                        height: 70.h,
                        child: const Text(
                          'Don\'t have an\naccount?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.10,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    verticalSpacing(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29.0),
                      child: SizedBox(
                        child: Text(
                          'Join us and start your journey today.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.09.h,
                          ),
                        ),
                      ),
                    ),
                    verticalSpacing(44),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.0.w),
                      child: CustomButton(
                        text: 'Create an account',
                        size: 14.sp,
                        heigh: 40.h,
                        width: 160.w,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpView()));
                        },
                      ),
                    ),
                    verticalSpacing(40),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
