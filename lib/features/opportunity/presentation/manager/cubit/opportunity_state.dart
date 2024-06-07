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
  final List<OpportunityModel> opportunities;
  OpportunitySearchSuccess({required this.opportunities});
}

final class OpportunitySearchError extends OpportunityState {
  final String message;
  OpportunitySearchError({required this.message});
}
