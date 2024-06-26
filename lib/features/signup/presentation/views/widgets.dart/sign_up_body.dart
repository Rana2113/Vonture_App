import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/components/text_field.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/login/presentation/views/login_view.dart';
import 'package:vonture_grad/features/place/data/models/requirements/requirements.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/requirements.dart';
import 'package:vonture_grad/features/signup/presentation/managers/cubit/sign_up_cubit.dart';
import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/date_widget.dart';
import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/role_button.dart';
import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/sign_up_button.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  List<String> value = [];
  List<String> itemSelected = [];
  List<int> selectedId = [];

  List<Requirements> requirements = [];

  @override
  void initState() {
    SignUpCubit.get(context).getSkills();
    print(SignUpCubit.get(context).listSkills.length);
    // SignUpCubit.get(context).listSkills.forEach((e) {
    //   requirements.add(e);
    //   value.add(e.name);
    //   setState(() {});
    // });
    super.initState();
  }

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

    return BlocConsumer<SignUpCubit, SignUpState>(
      builder: (context, state) {
        print(" hello $value");
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    verticalSpacing(40),
                    const CustomButtonRole(),
                    verticalSpacing(20),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: firstnamecontroller,
                            label: Text(
                              'First Name',
                              style: Styles.text14w500.copyWith(
                                fontSize: 10,
                                color: black,
                              ),
                            ),
                            hinttext: 'First Name',
                            height: 1,
                            size: 8,
                            suffixIcon: const Icon(
                              FontAwesomeIcons.circleUser,
                              color: PrimaryColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'first name is required';
                              }
                              return null;
                            },
                            type: TextInputType.name,
                          ),
                        ),
                        horizontalSpacing(16),
                        Expanded(
                          child: AppTextField(
                            controller: lastnamecontroller,
                            label: Text(
                              'Last Name',
                              style: Styles.text14w500.copyWith(
                                fontSize: 9,
                                height: 2,
                                color: black,
                              ),
                            ),
                            height: 1,
                            size: 8,
                            hinttext: 'Last Name',
                            suffixIcon: const Icon(
                              FontAwesomeIcons.circleUser,
                              color: PrimaryColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Last name is required';
                              }
                              return null;
                            },
                            type: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(10),
                    AppTextField(
                      label: const Text(
                        'Email',
                        style: Styles.text16w500,
                      ),
                      controller: emailcontroller,
                      hinttext: 'Email',
                      suffixIcon: const Icon(
                        Icons.alternate_email,
                        color: PrimaryColor,
                      ),
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
                    verticalSpacing(10),
                    AppTextField(
                        controller: passwordcontroller,
                        label: const Text(
                          'Password',
                          style: Styles.text16w500,
                        ),
                        hinttext: 'Password',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password is required';
                          }
                          if (!value.contains(RegExp(r'^(?=.*?[A-Z])'))) {
                            return 'Password not validated';
                          }

                          if (!value.contains(RegExp(r'^(?=.*?[0-9])'))) {
                            return 'Password not validated';
                          }

                          if (!value.contains(RegExp(r'^(?=.*?[!@#\$&*~])'))) {
                            return 'Password not validated';
                          }

                          return null;
                        },
                        type: TextInputType.visiblePassword,
                        isPassword: SignUpCubit.get(context).isPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: () {
                            SignUpCubit.get(context).changePasswordVisibility();
                          },
                          icon: Icon(
                            state is ChangePasswordVisibility &&
                                    state.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: PrimaryColor,
                          ),
                        )),
                    verticalSpacing(10),
                    AppTextField(
                      controller: phonenumbercontroller,
                      label: const Text(
                        'Phone number',
                        style: Styles.text16w500,
                      ),
                      hinttext: 'Phone Number',
                      suffixIcon: const Icon(
                        Icons.phone_enabled_outlined,
                        color: PrimaryColor,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'phone number is required';
                        }
                        return null;
                      },
                      type: TextInputType.phone,
                    ),
                    verticalSpacing(10),
                    AppTextField(
                      controller: countrycontroller,
                      label: const Text(
                        'Country',
                        style: Styles.text16w500,
                      ),
                      hinttext: 'Country',
                      suffixIcon: const Icon(
                        FontAwesomeIcons.earthAfrica,
                        color: PrimaryColor,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'country is required';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    verticalSpacing(10),
                    AppTextField(
                      controller: biocontroller,
                      maxLines: 2,
                      label: const Text(
                        'Bio',
                        style: Styles.text16w500,
                      ),
                      hinttext: 'Bio',
                      suffixIcon: const Icon(
                        Icons.notes,
                        color: PrimaryColor,
                      ),
                      validator: (value) {
                        if (value.isEmpty && value.length < 50) {
                          return 'Bio is required';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    verticalSpacing(10),
                    Date(
                      controller: birthdatecontroller,
                      hinttext: 'YYYY/MM/DD',
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: PrimaryColor,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Birthdate is required';
                        }
                        if (value != null &&
                            DateTime.now().year -
                                    int.parse(value.substring(0, 4)) <
                                18) {
                          return 'must be above 18 years old';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1940),
                          lastDate: DateTime(2006),
                        ).then((value) {
                          if (value != null) {
                            birthdatecontroller.text =
                                value.toString().substring(0, 10);
                          }
                        });
                      },
                      firstDate: null,
                    ),
                    verticalSpacing(10),
                    AppTextField(
                      controller: gendercontroller,
                      label: const Text(
                        'Gender',
                        style: Styles.text16w500,
                      ),
                      hinttext: 'Gender',
                      suffixIcon: const Icon(
                        FontAwesomeIcons.venusMars,
                        color: PrimaryColor,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Gender is required';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    verticalSpacing(24),
                    context.read<SignUpCubit>().selectedValue == "Tourist"
                        ? MultiSelectDropdown(
                            hinttext: "Select Your Skills",
                            onChanged: (val) {
                              selectedId = [];
                              for (var e in val) {
                                var req = requirements
                                    .firstWhere((val) => e == val.name);
                                selectedId.add(req.id);
                              }
                            },
                            value: itemSelected,
                            validator: (v) {},
                            items: value)
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    SignUpButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            itemSelected.isNotEmpty) {
                          SignUpCubit.get(context).signUP(
                            skills: selectedId,
                            firstname: firstnamecontroller.text,
                            lastname: lastnamecontroller.text,
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                            phonenumber: phonenumbercontroller.text,
                            nationality: countrycontroller.text,
                            bio: biocontroller.text,
                            birthdate: birthdatecontroller.text,
                            gender: gendercontroller.text,
                            role: SignUpCubit.get(context).selectedValue ==
                                    'Tourist'
                                ? 'TOURIST'
                                : SignUpCubit.get(context).selectedValue ==
                                        'Host'
                                    ? 'HOST'
                                    : 'null',
                          );
                        } else {
                          if (selectedId.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: error,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: const Text('Select your skills'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    verticalSpacing(18),
                    Row(
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
                                builder: (context) => const LoginView(),
                              ),
                            );
                            SignUpCubit.get(context).selectedValue = '';
                          },
                          child: Text(
                            'Login',
                            style: Styles.text16w500.copyWith(
                              color: PrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, SignUpState state) {
        if (state is GetSkillsSuccessState) {
          print(SignUpCubit.get(context).listSkills.length);
          SignUpCubit.get(context).listSkills.forEach((e) {
            requirements.add(e);
            value.add(e.name);
            setState(() {});
          });
        }
      },
    );
  }
}
