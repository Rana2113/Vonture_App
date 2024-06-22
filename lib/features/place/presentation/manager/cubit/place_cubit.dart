import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/features/place/data/models/applications/app_model.dart';
import 'package:vonture_grad/features/place/data/models/offers/offers.dart';
import 'package:vonture_grad/features/place/data/models/place_model/create_opportunity.dart';
import 'package:vonture_grad/features/place/data/models/place_model/place_model.dart';
import 'package:vonture_grad/features/place/data/models/requirements/requirements.dart';
import 'package:vonture_grad/features/place/data/models/profile%20_model/profile_model.dart';
import 'package:vonture_grad/features/place/data/models/review_model/review.dart';
import 'package:vonture_grad/features/place/data/place_repo_implementation.dart';

import '../../../../../core/constants.dart/api_constants.dart';
import '../../../../opportunity/presentation/managers/cubit/opportunity_cubit.dart';

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

  Future<void> getallplaceopportunity(int id) async {
    emit(GetAllPlaceOpportunityLoadingState());
    print("PlaceCubit: opportunity called");
    final response = await placeRepoImplementation.getallplaceopportunity(id);
    print("PlaceCubit: opportunity result: $response");
    response.fold(
      (failure) =>
          emit(GetAllPlaceOpportunityErrorState(message: failure.toString())),
      (opportunity) {
        print("PlaceCubit: opportunity successful - User: $opportunity");
        emit(GetAllPlaceOpportunitySucessState(opportunity: opportunity));
      },
    );
  }

  void uploadMedia(XFile media) {
    List<XFile> updatedMediaFiles = List.from(mediaFiles)..add(media);
    emit(UploadMedia(mediaFiles: updatedMediaFiles));
    print("PlaceCubit: Media files: $mediaFiles");
  }

  uploadProfile(dynamic image, BuildContext context) async {
    print(token);
    print(image);
    String fileName = image.split('/').last;
    const url = 'http://192.168.1.5:8000/users/profile_img';
    final formData = FormData.fromMap({
      'profile_img': await MultipartFile.fromFile(image, filename: fileName),
    });

    try {
      final response = await Dio().put(url,
          data: formData,
          options: Options(headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          }));
      print("/////////////////");
      print(response.data["message"]);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Image uploaded successfully")));
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
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

/////////////////////////////////////////////////uploadImage Profile///////////////////////////////////////

  Future<List<File>> uploadImagesToAPI(List<XFile> images) async {
    List<File> files = [];
    for (var image in images) {
      File file = File(image.path);
      files.add(file);
    }
    print("PlaceCubit: Files: $files");
    return files;
  }

/////////////////////////////////////////////////subscription///////////////////////////////////////
  Future getSubscription() async {
    String? url;
    emit(SubscriptionLoading());
    try {
      var response =
          await Dio().get("http://192.168.1.5:8000/plans/1/subscribe",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }));
      if (response.statusCode == 200) {
        url = response.data["session"];
        print(url);
        emit(SubscriptionSuccess(url: url!));
      }
    } catch (e) {
      emit(SubscriptionError(message: e.toString()));
      rethrow;
    }
    return url;
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> getRequirementsAndOffers() async {
    emit(GetRequirementAndOffersLoadingState());
    print("PlaceCubit: Fetching requirements and offers");

    final results = await Future.wait([
      placeRepoImplementation.getRequirements(),
      placeRepoImplementation.getOffers(),
    ]);

    final requirementsResult =
        results[0] as Either<Failure, List<Requirements>>;
    final offersResult = results[1] as Either<Failure, List<Offers>>;

    requirementsResult.fold(
      (failure) {
        print(
            "PlaceCubit: Fetching requirements failed - Error: ${failure.toString()}");
        emit(GetRequirementAndOffersErrorState(message: failure.toString()));
      },
      (requirements) {
        offersResult.fold(
          (failure) {
            print(
                "PlaceCubit: Fetching offers failed - Error: ${failure.toString()}");
            emit(
                GetRequirementAndOffersErrorState(message: failure.toString()));
          },
          (offers) {
            print("PlaceCubit: Fetching requirements and offers succeeded");
            emit(GetRequirementAndOffersSucessState(
              requirements: requirements,
              offers: offers,
            ));
          },
        );
      },
    );
  }

  Future<void> createOpportunity(
    int id, {
    required String title,
    required String description,
    required String from,
    required String to,
    required List<int> requirements,
    required List<int> offers,
  }) async {
    print("PlaceCubit: Creating opportunity");
    final result = await placeRepoImplementation.createopportunity(
      id,
      title,
      description,
      from,
      to,
      requirements,
      offers,
    );
    print("PlaceCubit: Create opportunity result: $result");
    result.fold(
      (failure) {
        print(
            "PlaceCubit: Create opportunity failed - Error: ${failure.toString()}");
        emit(CreateOpportunityErrorState(message: failure.toString()));
      },
      (createopportunity) {
        print(
            "PlaceCubit: Create opportunity successful - Opportunity: $createopportunity");
        emit(CreateOpportunitySucessState(opportunity: createopportunity));
      },
    );
  }

  Future<void> getotherprofile(int id, int opportunityID) async {
    emit(GetOtherProfileLoading());
    print("PlaceCubit: getotherprofile called with id: $id");
    final response =
        await placeRepoImplementation.getotherprofile(id, opportunityID);
    response.fold(
      (failure) {
        print("PlaceCubit: API call failed - Error: $failure");
        emit(GetOtherProfileError(message: failure.toString()));
      },
      (response) {
        print(
            "PlaceCubit  : API call successful - Response: ${response.toJson()}");
        emit(GetOtherProfileSuccess(application: response));
      },
    );
  }

  Future<void> getUserData() async {
    emit(GetOtherProfileLoading());
    print(
        "PlaceCubit: getotherprofile called with id: ${kidBox.get(kidBoxString)}");
    final response =
        await placeRepoImplementation.getUserData(kidBox.get(kidBoxString));
    response.fold(
      (failure) {
        print("PlaceCubit: API call failed - Error: $failure");
        emit(GetOtherProfileError(message: failure.toString()));
      },
      (response) {
        print(
            "PlaceCubit  : API call successful - Response: ${response.toJson()}");
        emit(GetOtherProfileSuccess(application: response));
      },
    );
  }

  Future<void> createreview(int id, double rating, String comment) async {
    emit(CreateReviewLoading());
    print("PlaceCubit: Creating review");
    final result =
        await placeRepoImplementation.createreview(id, rating, comment);
    print("PlaceCubit: Create review result: $result");
    result.fold(
      (failure) {
        print(
            "PlaceCubit: Create review failed - Error: ${failure.toString()}");
        emit(CreateReviewError(message: failure.errorMessages));
      },
      (review) {
        print("PlaceCubit: Create review successful - Review: $review");
        emit(CreateReviewSuccess(review: review));
      },
    );
  }

  Future<void> createReviewTourist(int id, int opportunityId, double rating,
      String comment, BuildContext context) async {
    emit(CreateReviewLoading());

    print("PlaceCubit: Creating review");
    final result =
        await placeRepoImplementation.createReviewTourist(id, rating, comment);
    print("PlaceCubit: Create review result: $result");
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              content: Text(failure.errorMessages),
              duration: const Duration(seconds: 3),
            ),
          );
        print(
            "PlaceCubit: Create review failed - Error: ${failure.errorMessages}");
        emit(CreateReviewError(message: failure.errorMessages));
      },
      (review) {
        print("PlaceCubit: Create review successful - Review: $review");
        BlocProvider.of<OpportunityCubit>(context)
            .getSpecifiOpportunity(opportunityId);
        emit(CreateReviewSuccess(review: review));
      },
    );
  }

  Future<void> acceptedApplication(int opportunityId, int touristId) async {
    emit(RejectApplicationLoading());
    print('PlaceCubit: Accepting application');
    final result = await placeRepoImplementation.acceptApplication(
        opportunityId, touristId);
    result.fold(
      (failure) {
        print(
            'PlaceCubit: Accept application failed - Error: ${failure.toString()}');
        emit(RejectApplicationError(message: failure.toString()));
      },
      (response) {
        print(
            'PlaceCubit: Accept application successful - Response: $response');
        getotherprofile(opportunityId, opportunityId);
        emit(RejectApplicationSuccess(application: response));
      },
    );
  }

  Future<void> rejectApplication(int opportunityId, int touristId) async {
    emit(RejectApplicationLoading());
    print('PlaceCubit: Rejecting application');
    final result = await placeRepoImplementation.rejectApplication(
        opportunityId, touristId);
    result.fold(
      (failure) {
        print(
            'PlaceCubit: Reject application failed - Error: ${failure.toString()}');
        emit(RejectApplicationError(message: failure.toString()));
      },
      (response) {
        print(
            'PlaceCubit: Reject application successful - Response: $response');
        emit(RejectApplicationSuccess(application: response));
      },
    );
  }
}
