import 'package:go_router/go_router.dart';
import 'package:vonture_grad/features/login/presentation/views/login_view.dart';
import 'package:vonture_grad/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kHome = '/home';
  static const String kLogin = '/login';
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
    ],
  );
}
