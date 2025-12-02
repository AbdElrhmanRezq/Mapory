import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/auth/data/repo/auth_repo_impl.dart';
import 'package:mapory/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
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
      providers: [BlocProvider(create: (context) => AuthCubit(AuthRepoImpl()))],
      child: MaterialApp.router(
        title: 'Mapory',
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: Color(0xFFf1f4f9),
          textTheme: GoogleFonts.montserratTextTheme().apply(
            bodyColor: Color(0xFF464747),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
