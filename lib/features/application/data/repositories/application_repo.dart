import 'package:dartz/dartz.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/features/application/data/models/application_model/application_model.dart';
import 'package:vonture_grad/features/application/data/models/application_model/tourists_model.dart';

abstract class ApplicationRepo {
  Future<Either<Failure, List<ApplicationModel>>> getmyapplication();

  Future<Either<Failure, List<TouristApplicationModel>>>
      getallapplicationopportunity(
    int opportunityId,
  );
}
