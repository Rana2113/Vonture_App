import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hinttext,
    this.suffixIcon,
    this.controller,
    required this.validator,
    this.onFieldSubmitted,
    required this.type,
    this.isPassword = false,
    this.firstDate,
    this.lastDate,
    this.label,
    this.maxLines = 1,
  });
  final String hinttext;
  final TextInputType type;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final Function validator;
  final void Function(String)? onFieldSubmitted;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Widget? label;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: TextFormField(
        maxLines: maxLines,
        // maxLines: 3,
        validator: (value) {
          return validator(value);
        },
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          label: label,
          hintText: hinttext,
          hintStyle: Styles.text14w500,
          errorStyle: Styles.text14w400.copyWith(color: error, height: 0.5),
          border: buildOutlineInputBorder(
            kBorderColor2,
          ),
          focusedBorder: buildOutlineInputBorder(
            black,
          ),
          errorBorder: buildOutlineInputBorder(
            PrimaryColor,
          ),
          focusedErrorBorder: buildOutlineInputBorder(PrimaryColor),
          contentPadding: const EdgeInsets.all(12),
        ),
        obscureText: isPassword,
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder(Color colorborder) {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: BorderColor,
        width: 2.w,
      ),
      borderRadius: BorderRadius.circular(5));
}
