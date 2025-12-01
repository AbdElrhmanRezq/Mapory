import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapory/core/utils/app_router.dart';

void main(List<String> args) {
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
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: Color(0xFF464747),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
