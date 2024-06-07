part of 'home_cubit.dart';

sealed class HomeState {
  get opportunities => null;
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class Homesucess extends HomeState {
  final List<OpportunityModel> opportunityList;
  Homesucess({required this.opportunityList});
}

final class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}

final class HomeSearchLoading extends HomeState {}

final class HomeSearchsucess extends HomeState {
  final List<OpportunityModel> opportunities;
  HomeSearchsucess({required this.opportunities});
}

final class HomeSearchError extends HomeState {
  final String message;
  HomeSearchError({required this.message});
}
