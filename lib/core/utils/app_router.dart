import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/core/utils/service_locator.dart';

import 'package:mapory/features/auth/presentation/screens/final_scr.dart';
import 'package:mapory/features/auth/presentation/screens/init_screen.dart';
import 'package:mapory/features/auth/presentation/screens/login_screen.dart';
import 'package:mapory/features/auth/presentation/screens/signup_screen.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/home/presentation/screens/home_screen.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo_impl.dart';
import 'package:mapory/features/profile/presentation/cubit/external_user_cubit/external_user_cubit.dart';
import 'package:mapory/features/profile/presentation/screens/photo_screen.dart';
import 'package:mapory/features/profile/presentation/screens/public_profile_screen.dart';

abstract class AppRouter {
  static const kInitialRoute = '/';
  static const kLoginRoute = '/login';
  static const kSignupRoute = '/signup';
  static const kHomeRoute = '/home';
  static const kPhotoRoute = '/photo';
  static const kPublicProfile = '/public_profile';

  static final router = GoRouter(
    routes: [
      GoRoute(path: kInitialRoute, builder: (context, state) => InitScreen()),
      GoRoute(path: kHomeRoute, builder: (context, state) => HomeScreen()),
      GoRoute(path: kLoginRoute, builder: (context, state) => LoginScreen()),
      GoRoute(path: kSignupRoute, builder: (context, state) => SignupScreen()),
      GoRoute(
        path: kPhotoRoute,
        builder: (context, state) {
          final photo = state.extra as PhotoModel;
          return PhotoScreen(photo: photo);
        },
      ),
      GoRoute(
        path: kPublicProfile,
        builder: (context, state) {
          final UserModel user = state.extra as UserModel;
          return BlocProvider(
            create: (context) =>
                ExternalUserCubit(getIt<UserRepoImpl>())
                  ..fetchUserData(userId: user.id),
            child: PublicProfileScreen(user: user),
          );
        },
      ),
    ],
  );
}
