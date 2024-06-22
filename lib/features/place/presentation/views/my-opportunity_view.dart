import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/add_opportunity_view.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/my_opportunity_view_body.dart';

class MyOpportunityView extends StatelessWidget {
  const MyOpportunityView({super.key, this.onPressed, required this.placeId});

  final void Function()? onPressed;
  final int placeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: MyOpportunityViewBody(
        placeId: placeId,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOpportunityView(
                placeId: placeId,
              ),
            ),
          );
        },
        backgroundColor: PrimaryColor,
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      title: Text(
        'Vonture',
        style: Styles.textlogo.copyWith(fontSize: 45.sp, color: PrimaryColor),
      ),
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: PrimaryColor,
        ),
        onPressed: () {
          final placeCubit = context.read<PlaceCubit>();
          placeCubit.getmyplace(placeId).then((_) {
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}

// AppBar(
//     centerTitle: true,
//     title: Text(
//       'Vonture',
//       style: Styles.textlogo.copyWith(fontSize: 45.sp, color: PrimaryColor),
//     ),
//     backgroundColor: white,
//     shadowColor: white,
//   );

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: kPrimaryColor,
//       surfaceTintColor: kLogoColor,
//       title: SizedBox(
//         height: 50.h,
//         width: 120.w,
//         child: Image.asset("assets/LOGO2.png"),
//       ),
//       centerTitle: true,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back,
//           color: kLogoColor,
//         ),
//         onPressed: () {
//           final place = BlocProvider.of<PlaceCubit>(context);
//           place.getmyplace(placeId).then((_) {
//             Navigator.pop(context);
//           });
//         },
//       ),
//     );
//   }
// }
