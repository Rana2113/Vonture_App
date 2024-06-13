import 'package:dartz/dartz.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/models/opportunity_model/opportunity_model.dart';

abstract class OpportunityRepo {
  Future<Either<Failure, List<OpportunityModel>>> getallopportunity();
  Future<Either<Failure, List<OpportunityModel>>> searchOpportunity(
      String query);

  Future<Either<Failure, OpportunityModel>> getSpecifiOpportunity(int id);
  Future<Either<Failure, OpportunityModel>> applyOpportunity(int id);
}
