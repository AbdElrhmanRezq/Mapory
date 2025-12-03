import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/auth/data/repo/auth_repo_impl.dart';
import 'package:mapory/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mapory/features/profile/data/repo/user_repo_impl.dart';
import 'package:mapory/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:mapory/features/profile/presentation/cubit/user_images_cubit/user_images_cubit.dart';
import 'package:mapory/features/profile/presentation/cubit/user_photos_cubit/user_photos_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  setup();

  runApp(Mapory());
}

class Mapory extends StatelessWidget {
  const Mapory({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt<AuthRepoImpl>())),
        BlocProvider(
          create: (context) =>
              UserDataCubit(getIt<UserRepoImpl>())..fetchUserData(),
        ),
        BlocProvider(
          create: (context) =>
              UserPhotosCubit(getIt<UserRepoImpl>())..fetchUserPhotos(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Mapory',
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: Color(0xFFf1f4f9),
          iconTheme: IconThemeData(color: KMainColor),
          textTheme: GoogleFonts.exoTextTheme().apply(
            bodyColor: Color(0xFF464747),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
