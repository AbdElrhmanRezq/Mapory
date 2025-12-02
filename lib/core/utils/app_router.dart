import 'package:go_router/go_router.dart';

import 'package:mapory/features/auth/presentation/screens/final_scr.dart';
import 'package:mapory/features/auth/presentation/screens/init_screen.dart';
import 'package:mapory/features/auth/presentation/screens/login_screen.dart';
import 'package:mapory/features/auth/presentation/screens/signup_screen.dart';

abstract class AppRouter {
  static const kInitialRoute = '/';
  static const kLoginRoute = '/login';
  static const kSignupRoute = '/signup';
  static const kHomeRoute = '/home';
  static const kEditProfileRoute = '/edit';
  static final router = GoRouter(
    routes: [
      GoRoute(path: kInitialRoute, builder: (context, state) => InitScreen()),
      GoRoute(path: kHomeRoute, builder: (context, state) => FinalScr()),
      GoRoute(path: kLoginRoute, builder: (context, state) => LoginScreen()),
      GoRoute(path: kSignupRoute, builder: (context, state) => SignupScreen()),
    ],
  );
}
