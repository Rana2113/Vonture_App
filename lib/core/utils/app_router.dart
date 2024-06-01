import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:vonture_grad/features/home/presentation/views/home_view.dart';
import 'package:vonture_grad/features/login/presentation/views/login_view.dart';
import 'package:vonture_grad/features/signup/presentation/views/sign_up.dart';
import 'package:vonture_grad/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kLogin = '/login';
  static const String kHome = '/home';
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
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}

void naivgateAndClear(context, widget) => Navigator.pushAndRemoveUntil(
        context, CupertinoPageRoute(builder: (context) => widget), (route) {
      return false;
    });
