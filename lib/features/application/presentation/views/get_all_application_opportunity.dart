import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/application/presentation/views/widgets/get_all_application_opportunity_body.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';

class GetAllApplicationOpportunity extends StatelessWidget {
  const GetAllApplicationOpportunity({super.key, required this.opportunityId});
  final int opportunityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarwithreturn(
        opportunityId: opportunityId,
      ),
      body: GetAllApplicationOpportunityBody(
        opportunityId: opportunityId,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      centerTitle: true,
      title: Text(
        'Vonture',
        style: Styles.textlogo.copyWith(
          fontSize: 45.sp,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: PrimaryColor,
        ),
        onPressed: () {
          final opportunitycubit = BlocProvider.of<OpportunityCubit>(context);
          opportunitycubit.getSpecifiOpportunity(opportunityId).then((_) {
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }
}

class AppBarwithreturn extends StatelessWidget implements PreferredSizeWidget {
  const AppBarwithreturn({
    super.key,
    required this.opportunityId,
  });
  final int opportunityId;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      child: AppBar(
        centerTitle: true,
        title: Text(
          'Vonture',
          style: Styles.textlogo.copyWith(fontSize: 45.sp, color: PrimaryColor),
        ),
        backgroundColor: white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: PrimaryColor,
          ),
          onPressed: () {
            final opportunitycubit = BlocProvider.of<OpportunityCubit>(context);
            opportunitycubit.getSpecifiOpportunity(opportunityId).then((_) {
              Navigator.of(context).pop();
            });
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
