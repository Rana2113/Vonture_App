import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        validator: (value) {
          return validator(value);
        },
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hinttext,
            hintStyle: TextStyle(
                color: kLogoColor,
                // const Color(0xff96734F),
                fontSize: 14.sp,
                height: 0.09,
                fontWeight: FontWeight.w400),
            border: buildOutlineInputBorder(
              kBorderColor2,
            ),
            focusedBorder: buildOutlineInputBorder(
              kFocusBorder,
            ),
            errorBorder: buildOutlineInputBorder(kErrorBorder),
            focusedErrorBorder: buildOutlineInputBorder(kErrorBorder),
            contentPadding: const EdgeInsets.all(12),
            filled: true,
            fillColor: kCardColor
            //const Color(0xffF5F2F0),
            // fillColor: const Color.fromARGB(255, 249, 239, 233),
            ),
        obscureText: isPassword,
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder(Color colorborder) {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: colorborder,
        width: 1.2.w,
      ),
      borderRadius: BorderRadius.circular(16));
}
