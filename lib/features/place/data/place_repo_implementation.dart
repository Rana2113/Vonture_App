import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/error/failures.dart';
import 'package:vonture_grad/core/utils/api_service.dart';
import 'package:vonture_grad/core/utils/end_points.dart';
import 'package:vonture_grad/features/place/data/models/place_model/place_model.dart';

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
}
