import 'package:get_it/get_it.dart';
import 'package:mapory/features/auth/data/repo/auth_repo.dart';
import 'package:mapory/features/auth/data/repo/auth_repo_impl.dart';
import 'package:mapory/features/profile/data/repo/user_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mapory/features/profile/data/repo/user_repo_impl.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl());
  getIt.registerSingleton<UserRepoImpl>(UserRepoImpl());
}
