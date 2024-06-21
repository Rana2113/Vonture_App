import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/utils/api_service.dart';
import 'package:vonture_grad/core/utils/end_points.dart';
import 'package:vonture_grad/features/application/data/models/application_model/application_model.dart';
import 'package:vonture_grad/features/application/data/models/application_model/tourists_model.dart';
import 'package:vonture_grad/features/application/data/repositories/application_repo.dart';

class ApplicationRepoImplementation implements ApplicationRepo {
  final ApiService apiService;

  ApplicationRepoImplementation({required this.apiService});

  @override
  Future<Either<Failure, List<ApplicationModel>>> getmyapplication() async {
    try {
      final response = await apiService.get(
        endPoint: EndPoints.application,
        jwt: token,
      );
      print("applicatopn: API call successful - Response: $response");

      List<ApplicationModel> applicationList = [];
      for (var application in response["applications"]) {
        applicationList.add(ApplicationModel.fromJson(application));
      }
      return Right(applicationList);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData ");

      print("application: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("application: API call failed - Error: $e");

      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, List<TouristApplicationModel>>>
      getallapplicationopportunity(int opportunityId) async {
    try {
      final response = await apiService.get(
        endPoint:
            '${EndPoints.opportunity}$opportunityId${EndPoints.application}',
        jwt: token,
      );
      print(
          "applicationOpportunity: API call successful - Response: $response");

      List<TouristApplicationModel> applicationList = [];
      for (var application in response["applications"]) {
        applicationList.add(TouristApplicationModel.fromJson(application));
      }
      return Right(applicationList);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData ");

      print("applicationOpportunity: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("applicationOpportunity: API call failed - Error: $e");

      return Left(ServerFailure(e.toString()));
    }
  }
}
