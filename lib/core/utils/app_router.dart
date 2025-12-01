import 'package:go_router/go_router.dart';
import 'package:mapory/features/auth/presentation/screens/login_screen.dart';

abstract class AppRouter {
  static const kInitialRoute = '/';
  static const kLoginRoute = '/auth/login';
  static final router = GoRouter(
    routes: [
      GoRoute(path: kLoginRoute, builder: (context, state) => LoginScreen()),
      GoRoute(path: kInitialRoute, builder: (context, state) => LoginScreen()),
    ],
  );
}
