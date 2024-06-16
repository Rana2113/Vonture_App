part of 'place_cubit.dart';

sealed class PlaceState {}

final class PlaceInitial extends PlaceState {}

final class PlaceSucessState extends PlaceState {
  final List<PlaceModel> placeList;
  PlaceSucessState({required this.placeList});
}

final class PlaceLoadingState extends PlaceState {}

final class PlaceErrorState extends PlaceState {
  final String message;
  PlaceErrorState({required this.message});
}

final class PlaceCreateLoadingState extends PlaceState {}

final class PlaceCreateSucessState extends PlaceState {
  final List<PlaceModel> place;
  PlaceCreateSucessState({required this.place});
}

final class PlaceCreateErrorState extends PlaceState {
  final String message;
  PlaceCreateErrorState({required this.message});
}

final class UploadMedia extends PlaceState {
  final List<XFile> mediaFiles;

  UploadMedia({required this.mediaFiles});
}
