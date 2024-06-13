part of 'opportunity_cubit.dart';

sealed class OpportunityState {
  get opportunities => null;
}

final class OpportunityInitial extends OpportunityState {}

final class OpportunityLoading extends OpportunityState {}

final class OpportunitySuccessState extends OpportunityState {
  final List<OpportunityModel> opportunityList;
  OpportunitySuccessState({required this.opportunityList});
}

final class OpportunityError extends OpportunityState {
  final String message;
  OpportunityError({required this.message});
}

final class OpportunitySearchLoading extends OpportunityState {}

final class OpportunitySearchSuccess extends OpportunityState {
  @override
  final List<OpportunityModel> opportunities;
  OpportunitySearchSuccess({required this.opportunities});
}

final class OpportunitySearchError extends OpportunityState {
  final String message;
  OpportunitySearchError({required this.message});
}

final class GetSpecifiOpportunityLoading extends OpportunityState {}

final class GetSpecifiOpportunitySuccess extends OpportunityState {
  final OpportunityModel detailsopportunity;
  GetSpecifiOpportunitySuccess({required this.detailsopportunity});
}

final class GetSpecifiOpportunityError extends OpportunityState {
  final String message;
  GetSpecifiOpportunityError({required this.message});
}

final class ApplyOpportunityLoading extends OpportunityState {}

final class ApplyOpportunitySuccess extends OpportunityState {
  final OpportunityModel applyopportunity;

  ApplyOpportunitySuccess({required this.applyopportunity});
}

final class ApplyOpportunityError extends OpportunityState {
  final String message;
  ApplyOpportunityError({required this.message});
}
