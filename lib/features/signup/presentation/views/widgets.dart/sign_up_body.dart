import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vonture_grad/core/components/app_bar.dart';
import 'package:vonture_grad/core/components/image.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/components/text_field.dart';
import 'package:vonture_grad/core/utils/service_locator.dart';
import 'package:vonture_grad/features/signup/data/sign_up_repo_implementation.dart';
import 'package:vonture_grad/features/signup/presentation/managers/cubit/sign_up_cubit.dart';
import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/date_widget.dart';
import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/role_button.dart';
import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/sign_up_button.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController firstnamecontroller = TextEditingController();
    TextEditingController lastnamecontroller = TextEditingController();
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController phonenumbercontroller = TextEditingController();
    TextEditingController countrycontroller = TextEditingController();
    TextEditingController biocontroller = TextEditingController();
    TextEditingController birthdatecontroller = TextEditingController();
    TextEditingController gendercontroller = TextEditingController();

    return BlocProvider(
      create: (context) => SignUpCubit(getIt<SignUpRepoImplementation>()),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomAppBar(text: 'Create Account'),
                  const CustomImage(image: 'assets/SignUp.png'),
                  verticalSpacing(40),
                  const CustomButtonRole(),
                  verticalSpacing(24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: AppTextField(
                                controller: firstnamecontroller,
                                hinttext: 'First Name',
                                suffixIcon:
                                    const Icon(FontAwesomeIcons.circleUser),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                type: TextInputType.name,
                              )),
                              Expanded(
                                  child: AppTextField(
                                controller: lastnamecontroller,
                                hinttext: 'Last Name',
                                suffixIcon:
                                    const Icon(FontAwesomeIcons.circleUser),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                type: TextInputType.name,
                              ))
                            ],
                          ),
                          verticalSpacing(24),
                          AppTextField(
                            controller: emailcontroller,
                            hinttext: 'Email',
                            suffixIcon: const Icon(Icons.alternate_email),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!value.contains('@')) {
                                return 'Invalid email';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                          ),
                          verticalSpacing(24),
                          AppTextField(
                            controller: passwordcontroller,
                            hinttext: 'Password',
                            suffixIcon: const Icon(Icons.password),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            type: TextInputType.visiblePassword,
                          ),
                          verticalSpacing(24),
                          AppTextField(
                            controller: phonenumbercontroller,
                            hinttext: 'Phone Number',
                            suffixIcon:
                                const Icon(Icons.phone_enabled_outlined),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            type: TextInputType.phone,
                          ),
                          verticalSpacing(24),
                          AppTextField(
                            controller: countrycontroller,
                            hinttext: 'Country',
                            suffixIcon:
                                const Icon(FontAwesomeIcons.earthAfrica),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your country';
                              }
                              return null;
                            },
                            type: TextInputType.text,
                          ),
                          verticalSpacing(24),
                          AppTextField(
                            controller: biocontroller,
                            hinttext: 'Bio',
                            suffixIcon: const Icon(Icons.notes),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your bio';
                              }
                              return null;
                            },
                            type: TextInputType.text,
                          ),
                          verticalSpacing(24),
                          Date(
                            controller: birthdatecontroller,
                            hinttext: 'YYYY/MM/DD',
                            suffixIcon: const Icon(FontAwesomeIcons.venusMars),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Birthdate';
                              }
                              return null;
                            },
                            type: TextInputType.text,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                if (value != null) {
                                  birthdatecontroller.text =
                                      value.toString().substring(0, 10);
                                }
                              });
                            },
                          ),
                          verticalSpacing(24),
                          AppTextField(
                            controller: gendercontroller,
                            hinttext: 'Gender',
                            suffixIcon: const Icon(FontAwesomeIcons.venusMars),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your gender';
                              }
                              return null;
                            },
                            type: TextInputType.text,
                          ),
                          verticalSpacing(24),
                          SignUpButton(onPressed: () {
                            if (formKey.currentState!.validate()) {
                              SignUpCubit.get(context).signUP(
                                  firstname: firstnamecontroller.text,
                                  lastname: lastnamecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  phonenumber: phonenumbercontroller.text,
                                  nationality: countrycontroller.text,
                                  bio: biocontroller.text,
                                  birthdate: birthdatecontroller.text,
                                  gender: gendercontroller.text,
                                  role:
                                      SignUpCubit.get(context).selectedValue ==
                                              'Tourist'
                                          ? 'TOURIST'
                                          : SignUpCubit.get(context)
                                                      .selectedValue ==
                                                  'Host'
                                              ? 'HOST'
                                              : 'null');
                            }
                          }),
                          verticalSpacing(24),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
