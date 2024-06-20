import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/features/place/data/models/applications/app_model.dart';
import 'package:vonture_grad/features/place/data/models/place_model/place_model.dart';
import 'package:vonture_grad/features/place/data/models/requirements/requirements.dart';
import 'package:vonture_grad/features/place/data/models/profile%20_model/profile_model.dart';
import 'package:vonture_grad/features/place/data/models/review_model/review.dart';

abstract class PlaceRepo {
  Future<Either<Failure, List<PlaceModel>>> getmyplace(int id);
  Future<Either<Failure, List<PlaceModel>>> createplace(
    String name,
    String location,
    String city,
    String country,
    String phone,
    String type,
    final List<File> media,
  );
  Future<Either<Failure, List<Requirements>>> getRequirements();
  Future<Either<Failure, List<Requirements>>> getOffers();
  Future<Either<Failure, List<Requirements>>> createopportunity(
    int id,
    String title,
    String description,
    String from,
    String to,
    List<int> requirements,
    List<int> offers,
  );
  Future<Either<Failure, List<Requirements>>> getallplaceopportunity(int id);
  Future<Either<Failure, ProfileModel>> getotherprofile(int id);
  Future<Either<Failure, ReviewModel>> createreview(
    int id,
    double rating,
    String comment,
  );
  Future<Either<Failure, Application>> acceptapplication(
      int opportunityid, int touristid);
  Future<Either<Failure, Application>> recjectapplication(
      int opportunityid, int touristid);
}
