import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

class Date extends StatefulWidget {
  const Date(
      {super.key,
      required this.hinttext,
      required this.type,
      this.suffixIcon,
      this.controller,
      this.validator,
      this.firstDate,
      this.lastDate,
      this.onTap});

  final String hinttext;
  final TextInputType type;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function()? onTap;

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          hintText: widget.hinttext,
          hintStyle: TextStyle(
              color: const Color(0xff96734F),
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
          fillColor: const Color(0xffF5F2F0),
          // fillColor: const Color.fromARGB(255, 249, 239, 233),
        ),
        onTap: widget.onTap,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color colorborder) {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: colorborder,
          width: 1.2.w,
        ),
        borderRadius: BorderRadius.circular(16));
  }
}

 









 //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 16.w),
  //     child: DOBInputField(
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime(2006),
  //       dateFormatType: DateFormatType.YYYYMMDD,
  //       showCursor: true,
  //       cursorColor: const Color(0xff96734F),
  //       inputDecoration: InputDecoration(
  //         suffixIcon: const Icon(Icons.calendar_today_outlined),
  //         border: buildOutlineInputBorder(
  //           kBorderColor2,
  //         ),
  //         focusedBorder: buildOutlineInputBorder(
  //           kFocusBorder,
  //         ),
  //         errorBorder: buildOutlineInputBorder(kErrorBorder),
  //         focusedErrorBorder: buildOutlineInputBorder(kErrorBorder),
  //         contentPadding: const EdgeInsets.all(12),
  //         filled: true,
  //         fillColor: const Color(0xffF5F2F0),
  //         // fillColor: const Color.fromARGB(255, 249, 239, 233),
  //       ),
  //     ),
  //   );
  // }

  // OutlineInputBorder buildOutlineInputBorder(Color colorborder) {
  //   return OutlineInputBorder(
  //       borderSide: BorderSide(
  //         color: colorborder,
  //         width: 1.2.w,
  //       ),
  //       borderRadius: BorderRadius.circular(16));
  // }
