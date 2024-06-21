part of 'application_cubit.dart';

sealed class ApplicationState {}

final class ApplicationInitial extends ApplicationState {}

final class ApplicationLoading extends ApplicationState {}

final class ApplicationSuccess extends ApplicationState {
  final List<ApplicationModel> applications;

  ApplicationSuccess({required this.applications});
}

final class ApplicationError extends ApplicationState {
  final String message;

  ApplicationError({required this.message});
}


final class PaymentLoading extends ApplicationState {

  PaymentLoading();

}

final class PaymentSuccess extends ApplicationState {
  final String url;

  PaymentSuccess({required this.url});
}

final class PaymentError extends ApplicationState {
  final String message;

  PaymentError({required this.message});
}

final class GetallApplicationOpportunityLoading extends ApplicationState {}

final class GetallAplicationOpportunitySuccess extends ApplicationState {
  final List<TouristApplicationModel> applications;

  GetallAplicationOpportunitySuccess({required this.applications});
}

final class GetallApplicationOpportunityError extends ApplicationState {
  final String message;

  GetallApplicationOpportunityError({required this.message});
}
