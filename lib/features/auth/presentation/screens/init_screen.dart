import 'package:flutter/material.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/auth/presentation/screens/widgets/init_screen_body.dart';
import 'package:mapory/features/home/presentation/screens/home_screen.dart';
import 'package:mapory/features/profile/presentation/screens/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = getIt<SupabaseClient>();
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, asyncSnapshot) {
        final Session? session = asyncSnapshot.data?.session;
        if (session == null) {
          return Scaffold(body: InitScreenBody());
        } else {
          return HomeScreen();
        }
      },
    );
  }
}
