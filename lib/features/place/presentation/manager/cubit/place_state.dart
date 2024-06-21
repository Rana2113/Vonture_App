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

final class GetRequirementAndOffersLoadingState extends PlaceState {}

final class GetRequirementAndOffersSucessState extends PlaceState {
  final List<Requirements> requirements;
  final List<Offers> offers;

  GetRequirementAndOffersSucessState(
      {required this.offers, required this.requirements});
}

final class GetRequirementAndOffersErrorState extends PlaceState {
  final String message;
  GetRequirementAndOffersErrorState({required this.message});
}






final class CreateOpportunityLoadingState extends PlaceState {}

final class CreateOpportunitySucessState extends PlaceState {
  final List<CreateOpportuntity> opportunity;
  CreateOpportunitySucessState({required this.opportunity});
}

final class CreateOpportunityErrorState extends PlaceState {
  final String message;
  CreateOpportunityErrorState({required this.message});
}

final class GetAllPlaceOpportunityLoadingState extends PlaceState {}

final class GetAllPlaceOpportunitySucessState extends PlaceState {
  final List<CreateOpportuntity> opportunity;
  GetAllPlaceOpportunitySucessState({required this.opportunity});
}

final class GetAllPlaceOpportunityErrorState extends PlaceState {
  final String message;
  GetAllPlaceOpportunityErrorState({required this.message});
}

final class GetOtherProfileLoading extends PlaceState {}

final class GetOtherProfileSuccess extends PlaceState {
  final ProfileModel application;

  GetOtherProfileSuccess({required this.application});
}

final class GetOtherProfileError extends PlaceState {
  final String message;

  GetOtherProfileError({required this.message});
}

final class CreateReviewLoading extends PlaceState {}

final class CreateReviewSuccess extends PlaceState {
  final ReviewModel review;

  CreateReviewSuccess({required this.review});
}

final class CreateReviewError extends PlaceState {
  final String message;

  CreateReviewError({required this.message});
}

final class AcceptApplicationLoading extends PlaceState {}

final class AcceptApplicationSuccess extends PlaceState {
  final Application application;

  AcceptApplicationSuccess({required this.application});
}

final class AcceptApplicationError extends PlaceState {
  final String message;

  AcceptApplicationError({required this.message});
}

final class RejectApplicationLoading extends PlaceState {}

final class RejectApplicationSuccess extends PlaceState {
  final Application application;

  RejectApplicationSuccess({required this.application});
}

final class RejectApplicationError extends PlaceState {
  final String message;

  RejectApplicationError({required this.message});
}
final class SubscriptionLoading extends PlaceState {

  SubscriptionLoading();

}

final class SubscriptionSuccess extends PlaceState {
  final String url;

  SubscriptionSuccess({required this.url});
}

final class SubscriptionError extends PlaceState {
  final String message;

  SubscriptionError({required this.message});
}