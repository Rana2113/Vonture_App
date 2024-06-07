import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/models/opportunity_model/opportunity_model.dart';
import 'package:vonture_grad/core/utils/api_service.dart';
import 'package:vonture_grad/core/utils/end_points.dart';
import 'package:vonture_grad/features/opportunity/data/opportunity_repo.dart';

class OpportunityRepoImplementation implements OpportunityRepo {
  final ApiService apiService;
  OpportunityRepoImplementation({required this.apiService});

  @override
  Future<Either<Failure, List<OpportunityModel>>> getallopportunity() async {
    try {
      final response = await apiService.get(
        endPoint: EndPoints.opportunity,
        jwt: token,
      );
      print("Home: API call successful - Response: $response");

      List<OpportunityModel> opportunityList = [];
      for (var opportunity in response["opportunities"]) {
        opportunityList.add(OpportunityModel.fromJson(opportunity));
      }
      return Right(opportunityList);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData ");

      print("Home: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("Home: API call failed - Error: $e");

      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<OpportunityModel>>> searchOpportunity(
      String query) async {
    try {
      final response = await apiService.get(
        endPoint: "${EndPoints.searchOpportunity}$query",
        jwt: token,
      );

      if (response["opportunities"] == null) {
        return Left(ServerFailure("No opportunities found"));
      }

      final List<OpportunityModel> opportunities = [];
      for (var opportunity in response["opportunities"]) {
        opportunities.add(OpportunityModel.fromJson(opportunity));
      }

      return Right(opportunities);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData");

      print("search: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("search: API call failed - Error: $e");

      return Left(ServerFailure(e.toString()));
    }
  }
}
