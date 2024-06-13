import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

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
          backgroundColor: kButtonColor,
        ),
        child: const Text(
          'Apply',
          style: TextStyle(
            color: Color(0xFF161411),
            fontSize: 16,
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
