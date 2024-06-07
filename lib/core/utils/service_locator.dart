import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vonture_grad/core/utils/api_service.dart';
import 'package:vonture_grad/features/opportunity/data/opportunity_repo_implementation.dart';
import 'package:vonture_grad/features/login/data/login_repo.dart';
import 'package:vonture_grad/features/login/data/login_repo_implementation.dart';
import 'package:vonture_grad/features/login/presentation/managers/cubit/login_cubit.dart';
import 'package:vonture_grad/features/signup/data/sign_up_repo.dart';
import 'package:vonture_grad/features/signup/data/sign_up_repo_implementation.dart';
import 'package:vonture_grad/features/signup/presentation/managers/cubit/sign_up_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => ApiService(
        Dio(),
      ));
  getIt.registerLazySingleton<LoginRepoImplementation>(
      () => LoginRepoImplementation(
            apiService: getIt<ApiService>(),
          ));
  getIt.registerFactory(() => LoginCubit(getIt<LoginRepo>()));
  getIt.registerLazySingleton<SignUpRepoImplementation>(
      () => SignUpRepoImplementation(
            apiService: getIt<ApiService>(),
          ));
  getIt.registerFactory(() => SignUpCubit(getIt<SignUpRepo>()));
  getIt.registerLazySingleton<OpportunityRepoImplementation>(
    () => OpportunityRepoImplementation(
      apiService: getIt<ApiService>(),
    ),
  );
}
