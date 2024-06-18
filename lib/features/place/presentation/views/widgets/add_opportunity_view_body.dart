import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/components/text_field.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/place/data/models/offers/offers.dart';
import 'package:vonture_grad/features/place/data/models/requirements/requirements.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/my-opportunity_view.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/add_opportunity_button.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/requirements.dart';
import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/date_widget.dart';

class AddOpportunityViewBody extends StatefulWidget {
  const AddOpportunityViewBody({super.key, required this.placeId});
  final int placeId;

  @override
  State<AddOpportunityViewBody> createState() => _AddOpportunityViewBodyState();
}

class _AddOpportunityViewBodyState extends State<AddOpportunityViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController availableControllerTo = TextEditingController();
  final TextEditingController availableControllerFrom = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<String> selectedRequirementNames = [];
  List<String> selectedOfferNames = [];
  List<int?> selectedRequirementIds = [];
  List<int?> selectedOfferIds = [];

  @override
  void initState() {
    super.initState();
    final placeCubit = BlocProvider.of<PlaceCubit>(context);
    placeCubit.getRequirementsAndOffers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceCubit, PlaceState>(
      listener: (context, state) {
        if (state is CreateOpportunityLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: PrimaryColor,
            )),
          );
        } else if (state is CreateOpportunityErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is CreateOpportunitySucessState) {
          Navigator.of(context).pop();

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MyOpportunityView(placeId: widget.placeId),
            ),
          );
        }
      },
      child: BlocBuilder<PlaceCubit, PlaceState>(
        builder: (context, state) {
          if (state is GetRequirementAndOffersLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: PrimaryColor,
            ));
          }

          if (state is GetRequirementAndOffersErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is GetRequirementAndOffersSucessState) {
            final requirements = state.requirements;
            final offers = state.offers;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: titleController,
                      hinttext: 'Title',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    verticalSpacing(24),
                    AppTextField(
                      controller: descriptionController,
                      hinttext: 'Description',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description';
                        } else if (value.length < 50) {
                          return 'Description must be at least 50 characters long';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    verticalSpacing(24),
                    Date(
                      controller: availableControllerFrom,
                      hinttext: 'Available From',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a date';
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
                            availableControllerFrom.text =
                                value.toString().substring(0, 10);
                          }
                        });
                      },
                    ),
                    verticalSpacing(24),
                    Date(
                      controller: availableControllerTo,
                      hinttext: 'Available To',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a date';
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
                            availableControllerTo.text =
                                value.toString().substring(0, 10);
                          }
                        });
                      },
                    ),
                    verticalSpacing(24),
                    MultiSelectDropdown(
                      hinttext: 'Requirements',
                      value: selectedRequirementNames,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select at least one requirement';
                        }
                        return null;
                      },
                      onChanged: (List<String> values) {
                        setState(() {
                          selectedRequirementNames = values;
                          selectedRequirementIds = values.map((name) {
                            final requirement = requirements.firstWhere(
                              (req) => req.name == name,
                              orElse: () => Requirements(
                                  id: -1, name: 'Unknown Requirement'),
                            );
                            return requirement.id;
                          }).toList();
                        });
                      },
                      items: requirements.map((e) => e.name).toList(),
                    ),
                    verticalSpacing(24),
                    MultiSelectDropdown(
                      hinttext: 'Offers',
                      value: selectedOfferNames,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select at least one offer';
                        }
                        return null;
                      },
                      onChanged: (List<String> values) {
                        setState(() {
                          selectedOfferNames = values;
                          selectedOfferIds = values.map((name) {
                            final offer = offers.firstWhere(
                              (offer) => offer.name == name,
                              orElse: () =>
                                  Offers(id: -1, name: 'Unknown Offer'),
                            );
                            return offer.id;
                          }).toList();
                        });
                      },
                      items: offers.map((e) => e.name ?? '').toList(),
                    ),
                    verticalSpacing(24),
                    AddOpportunityButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _handleSubmit(context);
                        }
                      },
                      placeId: widget.placeId,
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
              child: CircularProgressIndicator(
            color: PrimaryColor,
          ));
        },
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    final title = titleController.text;
    final description = descriptionController.text;
    final from = availableControllerFrom.text;
    final to = availableControllerTo.text;
    final requirements = selectedRequirementIds.whereType<int>().toList();
    final offers = selectedOfferIds.whereType<int>().toList();

    BlocProvider.of<PlaceCubit>(context).createOpportunity(
      widget.placeId,
      title: title,
      description: description,
      from: from,
      to: to,
      requirements: requirements,
      offers: offers,
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/core/components/text_field.dart';
// import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
// import 'package:vonture_grad/features/place/presentation/views/widgets/requirements.dart';
// import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/date_widget.dart';

// class AddOpportunityViewBody extends StatefulWidget {
//   const AddOpportunityViewBody({super.key});

//   @override
//   State<AddOpportunityViewBody> createState() => _AddOpportunityViewBodyState();
// }

// class _AddOpportunityViewBodyState extends State<AddOpportunityViewBody> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<String> selectedRequirements = [];
//   List<String> selectedOffers = [];

//   @override
//   void initState() {
//     super.initState();
//     final placeCubit = BlocProvider.of<PlaceCubit>(context);
//     placeCubit.getRequirementsAndOffers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(top: 20.w),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             AppTextField(
//               hinttext: 'Title',
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter a title';
//                 }
//                 return null;
//               },
//               type: TextInputType.text,
//             ),
//             verticalSpacing(24),
//             AppTextField(
//               hinttext: 'Description',
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter a description';
//                 }
//                 return null;
//               },
//               type: TextInputType.text,
//             ),
//             verticalSpacing(24),
//             Date(
//               hinttext: 'Available From',
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please select a date';
//                 }
//                 return null;
//               },
//               type: TextInputType.text,
//               onTap: () {
//                 showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime.now(),
//                 ).then((value) {});
//               },
//             ),
//             verticalSpacing(24),
//             Date(
//               hinttext: 'Available To',
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please select a date';
//                 }
//                 return null;
//               },
//               type: TextInputType.text,
//               onTap: () {
//                 showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime.now(),
//                 ).then((value) {});
//               },
//             ),
//             verticalSpacing(24),
//             BlocBuilder<PlaceCubit, PlaceState>(
//               builder: (context, state) {
//                 if (state is GetRequirementAndOffersLoadingState) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is GetRequirementAndOffersErrorState) {
//                   return Center(child: Text('Error: ${state.message}'));
//                 } else if (state is GetRequirementAndOffersSucessState) {
//                   final requirements = state.requirements;
//                   final offers = state.offers;
//                   return Column(
//                     children: [
//                       MultiSelectDropdown(
//                         hinttext: 'Requirements',
//                         value: selectedRequirements,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please select at least one requirement';
//                           }
//                           return null;
//                         },
//                         onChanged: (List<String> values) {
//                           setState(() {
//                             selectedRequirements = values;
//                           });
//                         },
//                         items: requirements.map((e) => e.name).toList(),
//                       ),
//                       verticalSpacing(24),
//                       MultiSelectDropdown(
//                         hinttext: 'Offers',
//                         value: selectedOffers,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please select at least one offer';
//                           }
//                           return null;
//                         },
//                         onChanged: (List<String> values) {
//                           setState(() {
//                             selectedOffers = values;
//                           });
//                         },
//                         items: offers.map((e) => e.name ?? '').toList(),
//                       ),
//                     ],
//                   );
//                 }
//                 return SizedBox.shrink();
//               },
//             ),
//             verticalSpacing(24),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Handle form submission
//                 }
//               },
//               child: const Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vonture_grad/core/components/spacing.dart';
// import 'package:vonture_grad/core/components/text_field.dart';
// import 'package:vonture_grad/features/signup/presentation/views/widgets.dart/date_widget.dart';
// import 'package:vonture_grad/features/place/presentation/views/widgets/requirements.dart';

// class AddOpportunityViewBody extends StatefulWidget {
//   const AddOpportunityViewBody({super.key});

//   @override
//   State<AddOpportunityViewBody> createState() => _AddOpportunityViewBodyState();
// }

// class _AddOpportunityViewBodyState extends State<AddOpportunityViewBody> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<String> selectedRequirements = [];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(top: 20.w),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             AppTextField(
//               hinttext: 'Title',
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter a title';
//                 }
//                 return null;
//               },
//               type: TextInputType.text,
//             ),
//             verticalSpacing(24),
//             AppTextField(
//               hinttext: 'Description',
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter a description';
//                 }
//                 return null;
//               },
//               type: TextInputType.text,
//             ),
//             verticalSpacing(24),
//             Date(
//               hinttext: 'Available From',
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please select a date';
//                 }
//                 return null;
//               },
//               type: TextInputType.text,
//               onTap: () {
//                 showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime.now(),
//                 ).then((value) {});
//               },
//             ),
//             verticalSpacing(24),
//             Date(
//               hinttext: 'Available To',
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please select a date';
//                 }
//                 return null;
//               },
//               type: TextInputType.text,
//               onTap: () {
//                 showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime.now(),
//                 ).then((value) {});
//               },
//             ),
//             verticalSpacing(24),
//             MultiSelectDropdown(
//               hinttext: 'Requirements',
//               items: [
//                 'Requirement 1',
//                 'Requirement 2',
//                 'Requirement 3',
//                 'Requirement 4',
//                 'Requirement 5',
//               ],
//               onChanged: (List<String> values) {
//                 setState(() {
//                   selectedRequirements = values;
//                 });
//               },
//               value: selectedRequirements,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select at least one requirement';
//                 }
//                 return null;
//               },
//             ),
//             verticalSpacing(24),
//             MultiSelectDropdown(
//               hinttext: 'offers',
//               items: [
//                 'offers 1',
//                 'offers 2',
//                 'offers 3',
//                 'offers 4',
//                 'offers 5',
//               ],
//               onChanged: (List<String> values) {
//                 setState(() {
//                   selectedRequirements = values;
//                 });
//               },
//               value: selectedRequirements,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select at least one requirement';
//                 }
//                 return null;
//               },
//             ),
//             verticalSpacing(24),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {}
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
