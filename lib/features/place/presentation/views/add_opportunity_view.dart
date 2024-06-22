import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/add_opportunity_view_body.dart';

class AddOpportunityView extends StatelessWidget {
  const AddOpportunityView({super.key, required this.placeId});
  final int placeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarwithReturn(
        placeId: placeId,
      ),
      body: AddOpportunityViewBody(
        placeId: placeId,
      ),
    );
  }
}

class AppBarwithReturn extends StatelessWidget implements PreferredSizeWidget {
  const AppBarwithReturn({super.key, required this.placeId});
  final int placeId;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Vonture',
        style: Styles.textlogo.copyWith(fontSize: 45.sp, color: PrimaryColor),
      ),
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: PrimaryColor,
        ),
        onPressed: () {
          final placeCubit = BlocProvider.of<PlaceCubit>(context);
          placeCubit.getallplaceopportunity(placeId).then((_) {
            Navigator.pop(context);
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
