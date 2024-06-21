import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/features/Home/presentation/views/widgets/home_nav_bar.dart';
import 'package:vonture_grad/features/application/data/models/application_model/application_model.dart';
import 'package:vonture_grad/features/application/data/models/application_model/tourists_model.dart';
import 'package:vonture_grad/features/application/data/repositories/application_repo_implementation.dart';
import 'package:vonture_grad/features/application/presentation/views/application_view.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/opportunity_view.dart';
import 'package:vonture_grad/features/place/data/models/applications/app_model.dart';

import '../../../../../core/constants.dart/api_constants.dart';
import '../../../../opportunity/presentation/managers/cubit/opportunity_cubit.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit(this.applicationRepoImplementation)
      : super(ApplicationLoading());
  final ApplicationRepoImplementation applicationRepoImplementation;

  static ApplicationCubit get(context) => BlocProvider.of(context);

  Future<void> getMyApplications() async {
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

  Future<void> deleteApplication(
      int opportunityId, BuildContext context) async {
    print(opportunityId);
    try {
      var response = await Dio().delete(
          "http://192.168.1.30:8000/opportunities/$opportunityId/application",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Deleted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      final opportunityCubit = BlocProvider.of<OpportunityCubit>(context);
        BlocProvider.of<ApplicationCubit>(context)
            .getMyApplications()
            .then((v) {
          Navigator.pop(context);
        });

    } catch (e) {
      print(e);
    }
  }

  Future getPayment(int id) async {
    String? url;
    emit(PaymentLoading());
    try {
      var response =
          await Dio().get("http://192.168.1.30:8000/opportunities/$id/payment",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }));
      if (response.statusCode == 200) {
        url = response.data["session"];
        print(url);
        emit(PaymentSuccess(url: url!));
      }
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
    return url;
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
