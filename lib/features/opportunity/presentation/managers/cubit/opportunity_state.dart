part of 'opportunity_cubit.dart';

abstract class OpportunityState {}

class OpportunityInitial extends OpportunityState {}

class OpportunityLoading extends OpportunityState {}

class OpportunitySuccessState extends OpportunityState {
  final List<OpportunityModel> opportunityList;
  OpportunitySuccessState({required this.opportunityList});
}

class OpportunityError extends OpportunityState {
  final String message;
  OpportunityError({required this.message});
}

class OpportunitySearchLoading extends OpportunityState {}

class OpportunitySearchSuccess extends OpportunityState {
  final List<OpportunityModel> opportunities;
  OpportunitySearchSuccess({required this.opportunities});
}

class OpportunitySearchError extends OpportunityState {
  final String message;
  OpportunitySearchError({required this.message});
}

class GetSpecifiOpportunityLoading extends OpportunityState {}

class GetSpecifiOpportunitySuccess extends OpportunityState {
  final OpportunityModel detailsopportunity;
  GetSpecifiOpportunitySuccess({required this.detailsopportunity});
}

class GetSpecifiOpportunityError extends OpportunityState {
  final String message;
  GetSpecifiOpportunityError({required this.message});
}

class ApplyOpportunityLoading extends OpportunityState {}

class ApplyOpportunitySuccess extends OpportunityState {
  final OpportunityModel applyopportunity;
  ApplyOpportunitySuccess({required this.applyopportunity});
}

class ApplyOpportunityError extends OpportunityState {
  final String message;
  ApplyOpportunityError({required this.message});
}
