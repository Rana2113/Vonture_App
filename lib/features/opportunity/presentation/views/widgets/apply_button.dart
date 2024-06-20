import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimaryColor,
        ),
        child: Text('Apply', style: Styles.text16w600.copyWith(color: white)),
      ),
    );
  }
}
