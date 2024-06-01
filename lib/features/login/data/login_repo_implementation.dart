import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/models/user_model.dart';
import 'package:vonture_grad/core/utils/api_service.dart';
import 'package:vonture_grad/features/login/data/login_repo.dart';

class LoginRepoImplementation implements LoginRepo {
  final ApiService apiService;
  LoginRepoImplementation({required this.apiService});

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      final response = await apiService.post(
        endPoint: '/auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      token = response["token"];
      kTokenBox.put(kTokenBoxString, token);
      kidBox.put(kidBoxString, response["user"]["id"]);
      return Right(UserModel.fromJson(response["user"]));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(
          e.toString(),
        ));
      }
    }
  }
}
