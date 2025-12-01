import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/features/auth/data/repo/auth_repo_impl.dart';
import 'package:mapory/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mapory/features/auth/presentation/screens/init_screen.dart';
import 'package:mapory/features/auth/presentation/screens/login_screen.dart';
import 'package:mapory/features/auth/presentation/screens/signup_screen.dart';

abstract class AppRouter {
  static const kInitialRoute = '/';
  static const kLoginRoute = '/login';
  static const kSignupRoute = '/signup';
  static final router = GoRouter(
    routes: [
      GoRoute(path: kInitialRoute, builder: (context, state) => InitScreen()),
      GoRoute(
        path: kLoginRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(AuthRepoImpl()),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: kSignupRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(AuthRepoImpl()),
          child: SignupScreen(),
        ),
      ),
    ],
  );
}
