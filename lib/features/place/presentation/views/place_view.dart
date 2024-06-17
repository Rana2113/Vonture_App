import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/add_place_view.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/app_bar.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/place_view_body.dart';

class MyPalceView extends StatelessWidget {
  const MyPalceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: BlocProvider.value(
          value: BlocProvider.of<PlaceCubit>(context),
          child: const PlaceViewBody(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddPlaceView()));
          },
          backgroundColor: kCardColor,
          child: const Icon(
            Icons.add,
            color: kLogoColor,
          ),
        ));
  }
}
