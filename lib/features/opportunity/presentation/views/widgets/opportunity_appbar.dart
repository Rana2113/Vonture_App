import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class OpportunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OpportunityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        centerTitle: true,
        title: Text(
          'Vonture',
          style: Styles.textlogo.copyWith(
            fontSize: 45.sp,
            color: PrimaryColor,
          ),
        ),
        backgroundColor: white,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
