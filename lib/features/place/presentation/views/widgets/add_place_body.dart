import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/components/text_field.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/add_place_button.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/pick_images.dart';

class AddPlaceBody extends StatefulWidget {
  const AddPlaceBody({super.key});

  @override
  _AddPlaceBodyState createState() => _AddPlaceBodyState();
}

class _AddPlaceBodyState extends State<AddPlaceBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  late List<XFile> mediaFiles;

  @override
  void initState() {
    super.initState();
    mediaFiles = [];
  }

  @override
  Widget build(BuildContext context) {
    final PlaceCubit placeCubit = context.read<PlaceCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppTextField(
              controller: nameController,
              hinttext: 'Place name',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            verticalSpacing(24),
            ImagePickerContainer(
              initialMediaFiles: mediaFiles,
              onImagesChanged: (List<XFile> updatedMediaFiles) {
                setState(() {
                  mediaFiles = updatedMediaFiles;
                });
              },
            ),
            verticalSpacing(24),
            AppTextField(
              controller: locationController,
              hinttext: 'Location',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            verticalSpacing(24),
            AppTextField(
              controller: cityController,
              hinttext: 'City',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a city';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            verticalSpacing(24),
            AppTextField(
              controller: countryController,
              hinttext: 'Country',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a country';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            verticalSpacing(24),
            AppTextField(
              controller: phoneController,
              hinttext: 'Phone number',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            verticalSpacing(24),
            AppTextField(
              controller: typeController,
              hinttext: 'Type of place',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a type';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            verticalSpacing(24),
            AddPlaceButton(
              onPressed: () {
                _createPlace(placeCubit);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createPlace(PlaceCubit placeCubit) {
    if (formKey.currentState!.validate()) {
      placeCubit.createPlace(
        name: nameController.text,
        location: locationController.text,
        city: cityController.text,
        country: countryController.text,
        phone: phoneController.text,
        type: typeController.text,
        mediaFiles: mediaFiles,
      );
    }
  }
}
