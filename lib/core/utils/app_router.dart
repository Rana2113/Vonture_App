import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:vonture_grad/core/models/user_model.dart';
import 'package:vonture_grad/features/Home/presentation/views/widgets/home_nav_bar.dart';
import 'package:vonture_grad/features/login/presentation/views/login_view.dart';
import 'package:vonture_grad/features/signup/presentation/views/signup_view.dart';
import 'package:vonture_grad/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kLogin = '/login';
  static const String kHome = '/HomeNavbar';
  static const String kSignUp = '/signup';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kLogin,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kSignUp,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: kHome,
        builder: (context, state) => const HomeNavBarWidget(),
      ),
    ],
  );
}

void naivgateAndClear(context, widget) => Navigator.pushAndRemoveUntil(
        context, CupertinoPageRoute(builder: (context) => widget), (route) {
      return false;
    });
