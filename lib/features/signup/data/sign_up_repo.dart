import 'package:dartz/dartz.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/models/user_model.dart';

import '../../place/data/models/requirements/requirements.dart';

abstract class SignUpRepo {
  Future<Either<Failure, UserModel>> signUp(
      String firstname,
      String lastname,
      String email,
      String password,
      String phonenumber,
      String nationality,
      String bio,
      String birthdate,
       List<int> id,

      String gender,
      String role);
  Future<Either<Failure, List<Requirements>>> skills();

}
