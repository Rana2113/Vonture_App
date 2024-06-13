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
