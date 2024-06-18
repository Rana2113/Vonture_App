import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/components/text_field.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  color: Colors.white,
                  height: 690.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        verticalSpacing(24),
                        const SizedBox(
                          width: 206,
                          height: 37,
                          child: Text(
                            'Great to see you again!',
                            textAlign: TextAlign.center,
                            style: Styles.text20w600black,
                          ),
                        ),
                        AppTextField(
                          hinttext: 'Email',
                          label: const Text(
                            'Email',
                            style: Styles.text16w500,
                          ),
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
                        verticalSpacing(10),
                        AppTextField(
                          label: const Text(
                            'Password',
                            style: Styles.text16w500,
                          ),
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
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: Icon(
                              state is ChangePasswordVisibility &&
                                      state.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                          ),
                          type: TextInputType.visiblePassword,
                        ),
                        verticalSpacing(44),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: LoginButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).login(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                          ),
                        ),
                        verticalSpacing(18),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: Styles.text16w600,
                              ),
                              horizontalSpacing(5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpView(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign up',
                                  style: Styles.text16w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
