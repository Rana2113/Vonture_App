import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/utils/api_service.dart';
import 'package:vonture_grad/core/utils/end_points.dart';
import 'package:vonture_grad/features/place/data/models/applications/app_model.dart';
import 'package:vonture_grad/features/place/data/models/offers/offers.dart';
import 'package:vonture_grad/features/place/data/models/place_model/create_opportunity.dart';
import 'package:vonture_grad/features/place/data/models/place_model/place_model.dart';
import 'package:vonture_grad/features/place/data/models/requirements/requirements.dart';
import 'package:vonture_grad/features/place/data/models/profile%20_model/profile_model.dart';
import 'package:vonture_grad/features/place/data/models/review_model/review.dart';

abstract class PlaceRepo {
  Future<Either<Failure, List<PlaceModel>>> getmyplace(int id);
}

class PlaceRepoImplementation implements PlaceRepo {
  final ApiService apiService;

  PlaceRepoImplementation({required this.apiService});

  @override
  Future<Either<Failure, List<PlaceModel>>> getmyplace(int id) async {
    try {
      final response = await apiService.get(
        endPoint: '${EndPoints.user}$id${EndPoints.place}',
        jwt: token,
      );

      print("Place: API call successful - Response: $response");

      if (response["places"] is List) {
        final List<PlaceModel> placeList = (response["places"] as List)
            .map((place) => PlaceModel.fromJson(place))
            .toList();

        print("Place: API call successful - Response: $placeList");

        return Right(placeList);
      } else {
        print("Place: API call failed - Invalid response format");
        return Left(ServerFailure("Invalid response format"));
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData");
      print("Place: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("Place: API call failed - Error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<CreateOpportuntity>>> getallplaceopportunity(
      int id) async {
    try {
      final response = await apiService.get(
          endPoint: '${EndPoints.place}/$id${EndPoints.opportunity}',
          jwt: token);
      print("Response from API: $response");
      if (response["opportunities"] is List) {
        final List<CreateOpportuntity> opportunityList =
            (response["opportunities"] as List)
                .map((opportunity) => CreateOpportuntity.fromJson(opportunity))
                .toList();
        return Right(opportunityList);
      } else {
        print("Unexpected response format: $response");
        return Left(ServerFailure("Invalid response format"));
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData");
      print("Place: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("Place: API call failed - Error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<PlaceModel>>> createplace(
    String name,
    String location,
    String city,
    String country,
    String phone,
    String type,
    List<File> media,
  ) async {
    try {
      List<MultipartFile> mediaFiles = [];
      for (var file in media) {
        String fileName = file.path.split('/').last;
        mediaFiles.add(
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        );
      }
      FormData formData = FormData.fromMap({
        "name": name,
        "pin": location,
        "city": city,
        "country": country,
        "phone_number": phone,
        "type": type,
        "images": mediaFiles,
      });
      final response = await apiService.post(
        endPoint: EndPoints.place,
        data: formData,
        jwt: token,
      );
      print("Response from API: $response");
      if (response.containsKey("place")) {
        PlaceModel place = PlaceModel.fromJson(response["place"]);
        return Right([place]);
      } else {
        print("Unexpected response format: $response");
        return Left(ServerFailure("Invalid response format"));
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData ");
      print("Place: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("Place: API call failed - Error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<CreateOpportuntity>>> createopportunity(
    int id,
    String title,
    String description,
    String from,
    String to,
    List<int> requirements,
    List<int> offers,
  ) async {
    try {
      final response = await apiService.post(
        endPoint: '${EndPoints.place}/$id${EndPoints.createopportunity}',
        data: {
          "title": title,
          "description": description,
          "from": from,
          "to": to,
          "requirements": requirements,
          "offers": offers,
        },
        jwt: token,
      );

      print("Response from API: $response");

      if (response.containsKey("opportunity")) {
        CreateOpportuntity opportunity =
            CreateOpportuntity.fromJson(response["opportunity"]);
        return Right([opportunity]);
      } else {
        print("Unexpected response format: $response");
        return Left(ServerFailure("Invalid response format"));
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData ");
      print("Place: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("Place: API call failed - Error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Requirements>>> getRequirements() async {
    try {
      final response = await apiService.getreq(
        endPoint: EndPoints.requirements,
        jwt: token,
      );

      print("Requirements API call successful - Response: $response");

      final List<Requirements> requirementsList = (response)
          .map((requirement) => Requirements.fromJson(requirement))
          .toList();

      print(
          "Requirements: API call successful - Requirements: $requirementsList");

      return Right(requirementsList);
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


  Future<Either<Failure, List<Offers>>> getOffers({String? jwt}) async {
    try {
      final responseData = await apiService.getreq(
        endPoint: '/offers',
        jwt: jwt,
      );

      List<Offers> offersList =
          responseData.map((json) => Offers.fromJson(json)).toList();
      return Right(offersList);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData");
      print("offers: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("offers: API call failed - Error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ProfileModel>> getotherprofile(int id,int opportunityID) async {
    try {
      final response =
          await apiService.get(endPoint: '${EndPoints.user}$id', jwt: token,data: {
            "opportunityId":opportunityID
          });
      print('otherProfile: API call successful - Response: $response');

      final ProfileModel touristprofile =
          ProfileModel.fromJson(response["user"]);
      return Right(touristprofile);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData");

      print("otherprofile: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("otherprofile: API call failed - Error: $e");

      return Left(ServerFailure(e.toString()));
    }
  }
  Future<Either<Failure, ProfileModel>> getUserData(int id) async {
    try {
      final response =
      await apiService.get(endPoint: '${EndPoints.user}$id', jwt: token);
      print('otherProfile: API call successful - Response: $response');

      final ProfileModel touristprofile =
      ProfileModel.fromJson(response["user"]);
      return Right(touristprofile);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      print("statuscode: $statusCode - response: $responseData");

      print("otherprofile: API call failed - Error: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("otherprofile: API call failed - Error: $e");

      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ReviewModel>> createreview(
    int id,
    double rating,
    String comment,
  ) async {
    try {
      final response = await apiService.post(
        endPoint: '${EndPoints.user}/$id${EndPoints.review}',
        data: {
          "comment": comment,
          "rating": rating,
        },
        jwt: token,
      );

      print("Response from API: $response");

      if (response.containsKey("review")) {
        ReviewModel review = ReviewModel.fromJson(response["review"]);
        return Right(review);
      } else {
        print("Unexpected response format: $response");
        return Left(ServerFailure("Invalid response format"));
      }
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        print("statuscode: $statusCode - response: $responseData ");
        return Left(responseData != null
            ? ServerFailure(responseData["message"])
            : ServerFailure.fromDioException(e));
      } else {
        print("Place: API call failed - Error: $e");

        return Left(ServerFailure(
          e.toString(),
        ));
      }
    }
  }


  Future<Either<Failure, ReviewModel>> createReviewTourist(
      int placeId,
      double rating,
      String comment,
      ) async {
    try {
      final response = await apiService.post(
        endPoint: '${EndPoints.place}/$placeId${EndPoints.review}',
        data: {
          "comment": comment,
          "rating": rating,
        },
        jwt: token,
      );

      print("Response from API: $response");

      if (response.containsKey("review")) {
        ReviewModel review = ReviewModel.fromJson(response["review"]);
        return Right(review);
      } else {
        print("Unexpected response format: $response");
        return Left(ServerFailure("Invalid response format"));
      }
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        print("statuscode: $statusCode - response: $responseData ");
        return Left(responseData != null
            ? ServerFailure(responseData["message"])
            : ServerFailure.fromDioException(e));
      } else {
        print("Place: API call failed - Error: $e");

        return Left(ServerFailure(
          e.toString(),
        ));
      }
    }
  }

  Future<Either<Failure, Application>> acceptApplication(
      int opportunityId, int touristId) async {
    try {
      final response = await apiService.put(
        endPoint: '${EndPoints.application}${EndPoints.accept}',
        data: {
          "opportunityId": opportunityId,
          "touristId": touristId,
        },
        jwt: token,
      );

      if (response["application"] != null) {
        final Application application =
            Application.fromJson(response["application"]);
        return Right(application);
      } else {
        return Left(ServerFailure("Invalid response from server"));
      }
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        print("statuscode: $statusCode - response: $responseData ");
        return Left(responseData != null
            ? ServerFailure(responseData["message"])
            : ServerFailure.fromDioException(e));
      } else {
        print("Place: API call failed - Error: $e");

        return Left(ServerFailure(e.toString()));
      }
    }
  }

  Future<Either<Failure, Application>> rejectApplication(
      int opportunityId, int touristId) async {
    try {
      final response = await apiService.put(
        endPoint: '${EndPoints.application}${EndPoints.reject}',
        data: {
          "opportunityId": opportunityId,
          "touristId": touristId,
        },
        jwt: token,
      );

      if (response["application"] != null) {
        final Application application =
            Application.fromJson(response["application"]);
        return Right(application);
      } else {
        return Left(ServerFailure("Invalid response from server"));
      }
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        print("statuscode: $statusCode - response: $responseData ");
        return Left(responseData != null
            ? ServerFailure(responseData["message"])
            : ServerFailure.fromDioException(e));
      } else {
        print("Place: API call failed - Error: $e");

        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
