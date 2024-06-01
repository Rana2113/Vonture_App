import 'package:dartz/dartz.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/models/user_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> login(String email, String password);
}
