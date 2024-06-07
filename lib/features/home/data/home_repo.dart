import 'package:dartz/dartz.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/models/opportunity_model/opportunity_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<OpportunityModel>>> getallopportunity();
  Future<Either<Failure, List<OpportunityModel>>> searchOpportunity(
      String query);
}
