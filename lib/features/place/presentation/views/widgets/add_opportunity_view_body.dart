import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/components/text_field.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/place/data/models/offers/offers.dart';
import 'package:vonture_grad/features/place/data/models/requirements/requirements.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    final PlaceCubit placeCubit = context.read<PlaceCubit>();

    return BlocBuilder<PlaceCubit, PlaceState>(
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
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: titleController,
                    label: const Text(
                      'Title',
                      style: Styles.text16w500,
                    ),
                    hinttext: 'Title',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    type: TextInputType.text,
                  ),
                  verticalSpacing(2),
                  AppTextField(
                    maxLines: 2,
                    controller: descriptionController,
                    label: const Text(
                      'Description',
                      style: Styles.text16w500,
                    ),
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
                  verticalSpacing(20),
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
                        initialDate: DateTime(1969, 1, 1),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      ).then((value) {
                        if (value != null) {
                          availableControllerFrom.text =
                              value.toString().substring(0, 10);
                        }
                      });
                    },
                  ),
                  verticalSpacing(35),
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
                  verticalSpacing(35),
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
                  verticalSpacing(35),
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
                            orElse: () => Offers(id: -1, name: 'Unknown Offer'),
                          );
                          return offer.id;
                        }).toList();
                      });
                    },
                    items: offers.map((e) => e.name ?? '').toList(),
                  ),
                  verticalSpacing(24),
                  Center(
                    child: AddOpportunityButton(
                      onPressed: () {
                        _createOpportunity(placeCubit);
                      },
                      placeId: widget.placeId,
                      onSuccess: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
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
    );
  }

  void _createOpportunity(PlaceCubit placeCubit) {
    if (formKey.currentState!.validate()) {
      placeCubit.createOpportunity(
        widget.placeId,
        title: titleController.text,
        description: descriptionController.text,
        from: availableControllerFrom.text,
        to: availableControllerTo.text,
        requirements: selectedRequirementIds.whereType<int>().toList(),
        offers: selectedOfferIds.whereType<int>().toList(),
      );
    }
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
