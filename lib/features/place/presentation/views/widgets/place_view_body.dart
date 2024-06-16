import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/place_card.dart';

class PlaceViewBody extends StatefulWidget {
  const PlaceViewBody({super.key});

  @override
  _PlaceViewBodyState createState() => _PlaceViewBodyState();
}

class _PlaceViewBodyState extends State<PlaceViewBody> {
  @override
  void initState() {
    super.initState();
    final userId = Hive.box(kidBoxString).get(kidBoxString);
    BlocProvider.of<PlaceCubit>(context).getmyplace(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is PlaceLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PlaceSucessState) {
          return ListView.builder(
            itemCount: state.placeList.length,
            itemBuilder: (context, index) {
              String title = state.placeList[index].name ?? 'No title';
              String country =
                  '${state.placeList[index].country ?? ''}, ${state.placeList[index].city ?? ''}';
              String rating =
                  state.placeList[index].rating?.toString() ?? 'No rating';

              return PlaceCard(
                title: title,
                country: country,
                rating: rating,
              );
            },
          );
        } else if (state is PlaceErrorState) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else {
          return const Center(
            child: Text('Unknown state'),
          );
        }
      },
    );
  }
}
