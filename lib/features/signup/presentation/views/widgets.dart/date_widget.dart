import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class Date extends StatefulWidget {
  const Date({
    super.key,
    required this.hinttext,
    required this.type,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.firstDate,
    this.lastDate,
    this.onTap,
  });

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
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        readOnly: true,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon ?? const Icon(Icons.calendar_today),
          hintText: widget.hinttext,
          hintStyle: Styles.text16w500,
          border: buildOutlineInputBorder(kBorderColor2),
          focusedBorder: buildOutlineInputBorder(kFocusBorder),
          errorBorder: buildOutlineInputBorder(kErrorBorder),
          focusedErrorBorder: buildOutlineInputBorder(kErrorBorder),
          contentPadding: const EdgeInsets.all(12),
          filled: true,
          fillColor: white,
        ),
        onTap: () async {
          final DateTime? pickedDate = await _selectDate(context);
          if (pickedDate != null) {
            setState(() {
              selectedDate = pickedDate;
              widget.controller?.text =
                  "${selectedDate.toLocal()}".split(' ')[0];
            });
          }
        },
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: PrimaryColor,
              onPrimary: PrimaryColor,
              surface: white,
              onSurface: PrimaryColor,
            ),
            dialogBackgroundColor: white,
          ),
          child: child!,
        );
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color colorborder) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: BorderColor,
        width: 1.2.w,
      ),
      borderRadius: BorderRadius.circular(5),
    );
  }
}
