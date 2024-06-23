import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/models/user_model.dart';
import 'package:vonture_grad/core/utils/api_service.dart';
import 'package:vonture_grad/core/utils/end_points.dart';
import 'package:vonture_grad/features/signup/data/sign_up_repo.dart';

import '../../place/data/models/requirements/requirements.dart';

class SignUpRepoImplementation implements SignUpRepo {
  final ApiService apiService;

  SignUpRepoImplementation({required this.apiService});
  @override
  Future<Either<Failure, UserModel>> signUp(
      String firstname,
      String lastname,
      String email,
      String password,
      String phonenumber,
      String nationality,
      String bio,
      String birthdate,
      List<int> skills,
      String gender,
      String role) async {
    try {
      final response = await apiService.post(endPoint: EndPoints.signUp, data: {
        "first_name": firstname,
        "last_name": lastname,
        "email": email,
        "password": password,
        "phone_number": phonenumber,
        "nationality": nationality,
        "bio": bio,
        "birthdate": birthdate,
        "gender": gender,
        "skills": skills,
        "role": role,
      });
      print("SignUprepo: API call successful - Response: $response");

      token = response["token"];
      kTokenBox.put(kTokenBoxString, response["user"]["id"]);
      kTokenBox.put(kTokenBoxString, token);
      kRoleBox.put(kRoleBoxString, response["user"]["role"]);
      kTouristApplicationsBox.put(kTouristApplicationsBoxString,
          response["user"]["toursitApplications"]);
      print(response["user"]["role"]);
      print(response["user"]["toursitApplications"]);

      return Right(UserModel.fromJson(response["user"]));
    } catch (e) {
      if (e is DioException) {
        print("SignUprepo: API call failed - Error: $e");
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(
          e.toString(),
        ));
      }
    }
  }

  @override
  Future<Either<Failure, List<Requirements>>> skills() async {
    try {
      final response = await apiService.getreq(
        endPoint: EndPoints.skills,
        jwt: token,
      );

      print("Requirements API call successful - Response: $response");

      final List<Requirements> skillsList = (response)
          .map((requirement) => Requirements.fromJson(requirement))
          .toList();

      print("Requirements: API call successful - Requirements: $skillsList");

      return Right(skillsList);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData");
      print("Requirements: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("Requirements: API call failed - Error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }
}
