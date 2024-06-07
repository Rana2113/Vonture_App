import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/appbarlogo.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/opportunity_view_body.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/widgets/search_opportunity.dart';

class OpportunityView extends StatelessWidget {
  const OpportunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const OpportunityAppBar(),
          verticalSpacing(20.h),
          const SearchOpportunity(),
          verticalSpacing(20.h),
          const OpportunityViewBody(),
        ],
      ),
    );
  }
}
