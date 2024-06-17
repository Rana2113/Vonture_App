import 'package:flutter/material.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/add_place_body.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/app_bar.dart';

class AddPlaceView extends StatefulWidget {
  const AddPlaceView({super.key});

  @override
  State<AddPlaceView> createState() => _AddPlaceViewState();
}

class _AddPlaceViewState extends State<AddPlaceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const AddPlaceBody(),
    );
  }
}
