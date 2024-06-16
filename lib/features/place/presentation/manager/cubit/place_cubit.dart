import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vonture_grad/features/place/data/models/place_model/place_model.dart';
import 'package:vonture_grad/features/place/data/place_repo_implementation.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit(this.placeRepoImplementation) : super(PlaceLoadingState());
  final PlaceRepoImplementation placeRepoImplementation;
  static PlaceCubit get(context) => BlocProvider.of(context);
  Future<void> getmyplace(int id) async {
    emit(PlaceLoadingState());
    print("PlaceCubit: Place called");
    final response = await placeRepoImplementation.getmyplace(id);
    print("PlaceCubit: Place result: $response");
    response.fold(
      (failure) => emit(PlaceErrorState(message: failure.toString())),
      (placeList) {
        print("PlaceCubit: Place successful - User: $placeList");
        emit(PlaceSucessState(placeList: placeList));
      },
    );
  }

  void uploadMedia(XFile media) {
    List<XFile> updatedMediaFiles = List.from(mediaFiles)..add(media);
    emit(UploadMedia(mediaFiles: updatedMediaFiles));
    print("PlaceCubit: Media files: $mediaFiles");
  }

  Future<void> createPlace({
    required String name,
    required String location,
    required String city,
    required String country,
    required String phone,
    required String type,
    required List<XFile> mediaFiles,
  }) async {
    emit(PlaceCreateLoadingState());
    print("PlaceCubit: Place called");

    try {
      List<File> files = await uploadImagesToAPI(mediaFiles);

      final response = await placeRepoImplementation.createplace(
        name,
        location,
        city,
        country,
        phone,
        type,
        files,
      );
      print("PlaceCubit: Place result: $response");

      response.fold(
          (failure) => emit(PlaceCreateErrorState(message: failure.toString())),
          (places) {
        emit(PlaceCreateSucessState(place: places));
        print("PlaceCubit: Place successful - Place: $places");
      });
    } catch (e) {
      emit(PlaceCreateErrorState(message: e.toString()));
    }
  }

  List<XFile> mediaFiles = [];

  void removeMedia(XFile media) {
    List<XFile> updatedMediaFiles = List.from(mediaFiles)
      ..removeWhere((element) => element.path == media.path);
    emit(UploadMedia(mediaFiles: updatedMediaFiles));
    print("PlaceCubit: Media files: $mediaFiles");
  }

  Future<List<File>> uploadImagesToAPI(List<XFile> images) async {
    List<File> files = [];
    for (var image in images) {
      File file = File(image.path);
      files.add(file);
    }
    print("PlaceCubit: Files: $files");
    return files;
  }
}
