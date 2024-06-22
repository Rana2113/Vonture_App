import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/application/presentation/views/widgets/application_view_body.dart';

class ApplicationView extends StatelessWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const ApplicationViewBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      title: Text(
        'Vonture',
        style: Styles.textlogo.copyWith(fontSize: 45.sp, color: PrimaryColor),
      ),
    );
  }
}
