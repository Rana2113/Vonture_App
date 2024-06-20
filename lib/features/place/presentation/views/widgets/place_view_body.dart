import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/add_opportunity_view.dart';
import 'package:vonture_grad/features/place/presentation/views/my-opportunity_view.dart';
import 'package:vonture_grad/features/place/presentation/views/widgets/place_card.dart';

class PlaceViewBody extends StatefulWidget {
  const PlaceViewBody({
    super.key,
  });

  @override
  _PlaceViewBodyState createState() => _PlaceViewBodyState();
}

class _PlaceViewBodyState extends State<PlaceViewBody> {
  @override
  void initState() {
    super.initState();
    _fetchPlaces();
  }

  void _fetchPlaces() {
    final userId = Hive.box(kidBoxString).get(kidBoxString);
    BlocProvider.of<PlaceCubit>(context).getmyplace(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is PlaceLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: PrimaryColor,
            ),
          );
        } else if (state is PlaceSucessState) {
          return ListView.builder(
            itemCount: state.placeList.length,
            itemBuilder: (context, index) {
              final place = state.placeList[index];
              String title = place.name ?? 'No title';
              String country = '${place.country ?? ''}, ${place.city ?? ''}';
              String rating = place.rating?.toString() ?? 'No rating';
              String placeState = place.status!;
              String imageUrl =
                  (place.placeMedia != null && place.placeMedia!.isNotEmpty)
                      ? place.placeMedia!.first
                      : 'default_image_url'; // Ensure there's a default value

              return PlaceCard(
                title: title,
                country: country,
                rating: rating,
                state: placeState,
                imageUrl: imageUrl,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyOpportunityView(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddOpportunityView(
                                placeId: place.id!,
                              ),
                            ),
                          ).then((_) {
                            _fetchPlaces();
                          });
                        },
                        placeId: place.id!,
                      ),
                    ),
                  ).then((_) {
                    _fetchPlaces();
                  });
                },
              );
            },
          );
        } else if (state is PlaceErrorState) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: PrimaryColor,
            ),
          );
        }
      },
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:vonture_grad/core/constants.dart/api_constants.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';
// import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
// import 'package:vonture_grad/features/place/presentation/views/add_opportunity_view.dart';
// import 'package:vonture_grad/features/place/presentation/views/my-opportunity_view.dart';
// import 'package:vonture_grad/features/place/presentation/views/widgets/place_card.dart';

// class PlaceViewBody extends StatefulWidget {
//   const PlaceViewBody({
//     super.key,
//   });

//   @override
//   _PlaceViewBodyState createState() => _PlaceViewBodyState();
// }

// class _PlaceViewBodyState extends State<PlaceViewBody> {
//   @override
//   void initState() {
//     super.initState();
//     _fetchPlaces();
//   }

//   void _fetchPlaces() {
//     final userId = Hive.box(kidBoxString).get(kidBoxString);
//     BlocProvider.of<PlaceCubit>(context).getmyplace(userId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PlaceCubit, PlaceState>(
//       builder: (context, state) {
//         if (state is PlaceLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: PrimaryColor,
//             ),
//           );
//         } else if (state is PlaceSucessState) {
//           return ListView.builder(
//             itemCount: state.placeList.length,
//             itemBuilder: (context, index) {
//               final place = state.placeList[index];
//               String title = place.name ?? 'No title';
//               String country = '${place.country ?? ''}, ${place.city ?? ''}';
//               String rating = place.rating?.toString() ?? 'No rating';
//               String placeState = place.status!;

//               return PlaceCard(
//                 title: title,
//                 country: country,
//                 rating: rating,
//                 state: placeState,
//                 ontap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MyOpportunityView(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AddOpportunityView(
//                                 placeId: place.id!,
//                               ),
//                             ),
//                           ).then((_) {
//                             _fetchPlaces();
//                           });
//                         },
//                         placeId: place.id!,
//                       ),
//                     ),
//                   ).then((_) {
//                     _fetchPlaces();
//                   });
//                 },
//               );
//             },
//           );
//         } else if (state is PlaceErrorState) {
//           return Center(
//             child: Text('Error: ${state.message}'),
//           );
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: PrimaryColor,
//             ),
//           );
//         }
//       },
//     );
//   }
// }










// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:vonture_grad/core/constants.dart/api_constants.dart';
// import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
// import 'package:vonture_grad/features/place/presentation/views/add_opportunity_view.dart';
// import 'package:vonture_grad/features/place/presentation/views/my-opportunity_view.dart';
// import 'package:vonture_grad/features/place/presentation/views/widgets/place_card.dart';

// class PlaceViewBody extends StatefulWidget {
//   const PlaceViewBody({super.key});

//   @override
//   _PlaceViewBodyState createState() => _PlaceViewBodyState();
// }

// class _PlaceViewBodyState extends State<PlaceViewBody> {
//   @override
//   void initState() {
//     super.initState();
//     final userId = Hive.box(kidBoxString).get(kidBoxString);
//     BlocProvider.of<PlaceCubit>(context).getmyplace(userId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PlaceCubit, PlaceState>(
//       builder: (context, state) {
//         if (state is PlaceLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is PlaceSucessState) {
//           return ListView.builder(
//             itemCount: state.placeList.length,
//             itemBuilder: (context, index) {
//               String title = state.placeList[index].name ?? 'No title';
//               String country =
//                   '${state.placeList[index].country ?? ''}, ${state.placeList[index].city ?? ''}';
//               String rating =
//                   state.placeList[index].rating?.toString() ?? 'No rating';
//               String placeState = state.placeList[index].status!;

//               return PlaceCard(
//                 title: title,
//                 country: country,
//                 rating: rating,
//                 state: placeState,
//                 ontap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MyOpportunityView(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AddOpportunityView(
//                                 placeId: state.placeList[index].id!,
//                               ),
//                             ),
//                           );
//                         },
//                         placeId: state.placeList[index].id!,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         } else if (state is PlaceErrorState) {
//           return Center(
//             child: Text('Error: ${state.message}'),
//           );
//         } else {
//           return const Center();
//         }
//       },
//     );
//   }
// }
