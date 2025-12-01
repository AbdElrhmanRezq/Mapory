import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
}
