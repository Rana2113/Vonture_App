import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/utils/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vonture_grad/core/utils/service_locator.dart';
import 'package:vonture_grad/features/application/data/repositories/application_repo_implementation.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/opportunity/data/opportunity_repo_implementation.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
import 'package:vonture_grad/features/place/data/place_repo_implementation.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/signup/data/sign_up_repo_implementation.dart';
import 'package:vonture_grad/features/signup/presentation/managers/cubit/sign_up_cubit.dart';

void main() async {
  setup();
  await Hive.initFlutter();

  await Hive.openBox(kTokenBoxString);
  await Hive.openBox(kidBoxString);
  await Hive.openBox(kRoleBoxString);
  await Hive.openBox(kTouristApplicationsBoxString);

  runApp(const VontureApp());
}

class VontureApp extends StatelessWidget {
  const VontureApp({super.key});
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                OpportunityCubit(getIt<OpportunityRepoImplementation>())),
        BlocProvider(
            create: (context) =>
                SignUpCubit(getIt<SignUpRepoImplementation>())..getSkills()),
        BlocProvider(
            create: (context) =>
            PlaceCubit(getIt<PlaceRepoImplementation>())..getUserData()),
        BlocProvider(
            create: (context) =>
                ApplicationCubit(getIt<ApplicationRepoImplementation>())),
        BlocProvider(
            create: (context) => PlaceCubit(getIt<PlaceRepoImplementation>())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(482, 926),
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xffFFFFFF),
          ),

        ),

      ),
    );
  }
}
