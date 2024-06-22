import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';

class ImagePickerContainer extends StatefulWidget {
  final List<XFile> initialMediaFiles;
  final Function(List<XFile>) onImagesChanged;

  const ImagePickerContainer({
    super.key,
    required this.initialMediaFiles,
    required this.onImagesChanged,
  });

  @override
  _ImagePickerContainerState createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  late List<XFile> mediaFiles;

  @override
  void initState() {
    super.initState();
    mediaFiles = List.from(widget.initialMediaFiles);
  }

  @override
  Widget build(BuildContext context) {
    final PlaceCubit placeCubit = context.read<PlaceCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Images', style: Styles.text16w500.copyWith(height: -0.1)),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: BorderColor, width: 2.w)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: mediaFiles
                          .map((media) => Stack(
                                children: [
                                  Image.file(
                                    File(media.path),
                                    height: 80.h,
                                    width: 80.w,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        _removeImage(media);
                                        placeCubit.removeMedia(media);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: PrimaryColor,
                                        ),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.photo_library,
                      color: PrimaryColor,
                    ),
                    onPressed: () {
                      _pickImage(context, placeCubit);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage(BuildContext context, PlaceCubit placeCubit) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((XFile? value) {
      if (value != null) {
        _addImage(value);
        placeCubit.uploadMedia(value);
      }
    });
  }

  void _addImage(XFile image) {
    setState(() {
      mediaFiles.add(image);
      widget.onImagesChanged(mediaFiles);
    });
  }

  void _removeImage(XFile image) {
    setState(() {
      mediaFiles.remove(image);
      widget.onImagesChanged(mediaFiles);
    });
  }
}
