import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(Mapory());
}

class Mapory extends StatelessWidget {
  const Mapory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mapory',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Color(0xFFf1f4f9),
        textTheme: GoogleFonts.montserratTextTheme().apply(
          bodyColor: Color(0xFF464747),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
