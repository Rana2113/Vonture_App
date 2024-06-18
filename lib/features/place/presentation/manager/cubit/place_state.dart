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

// final class CloseOpportunity extends PlaceState {
//   final OpportunityModel closeOpportunity;
//   CloseOpportunity({required this.closeOpportunity});
// }

// final class CloseOpportunityLoading extends PlaceState {}

// final class CloseOpportunityError extends PlaceState {
//   String message;
//   CloseOpportunityError({required this.message});
// }

// final class GetOffersLoadingState extends PlaceState {}

// final class GetOffersSucessState extends PlaceState {
//   final List<Offers> offers;
//   GetOffersSucessState({required this.offers});
// }

// final class GetOffersErrorState extends PlaceState {
//   final String message;
//   GetOffersErrorState({required this.message});
// }
