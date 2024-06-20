import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
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
        backgroundColor: kCardColor,
        child: const Icon(
          Icons.add,
          color: kLogoColor,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: SizedBox(
        height: 50,
        width: 120,
        child: Image.asset("assets/LOGO2.png"),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: kLogoColor,
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
