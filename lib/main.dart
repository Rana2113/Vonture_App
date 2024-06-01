import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/utils/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vonture_grad/core/utils/service_locator.dart';

void main() async {
  setup();
  await Hive.initFlutter();
  await Hive.openBox(kTokenBoxString);
  await Hive.openBox(kidBoxString);
  runApp(const VontureApp());
}

class VontureApp extends StatelessWidget {
  const VontureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(388, 920),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
        ),
      ),
    );
  }
}
