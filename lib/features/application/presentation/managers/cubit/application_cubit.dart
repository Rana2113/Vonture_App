import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/features/application/data/models/application_model/application_model.dart';
import 'package:vonture_grad/features/application/data/models/application_model/tourists_model.dart';
import 'package:vonture_grad/features/application/data/repositories/application_repo_implementation.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit(this.applicationRepoImplementation)
      : super(ApplicationLoading());
  final ApplicationRepoImplementation applicationRepoImplementation;
  static ApplicationCubit get(context) => BlocProvider.of(context);

  Future<void> getallopportunity() async {
    emit(ApplicationLoading());
    print("application: application called");
    final response = await applicationRepoImplementation.getmyapplication();
    print("application: application result: $response");

    response.fold(
      (failure) => emit(ApplicationError(message: failure.toString())),
      (applications) {
        print("application: application successful - User: $applications");

        emit(ApplicationSuccess(applications: applications));
      },
    );
  }

  Future<void> getallapplicationopportunity(int opportunityId) async {
    emit(GetallApplicationOpportunityLoading());
    print("application: application called");
    final response = await applicationRepoImplementation
        .getallapplicationopportunity(opportunityId);
    print("application: application result: $response");

    response.fold(
      (failure) =>
          emit(GetallApplicationOpportunityError(message: failure.toString())),
      (applications) {
        print("application: application successful - User: $applications");
        emit(GetallAplicationOpportunitySuccess(applications: applications));
      },
    );
  }
}
