import 'package:dartz/dartz.dart';
import 'package:mapory/core/errors/failures.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/auth/data/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl implements AuthRepo {
  final supabase = getIt<SupabaseClient>();
  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      final user = supabase.auth.currentUser;

      if (user != null) {
        final userCheck = await supabase
            .from('users')
            .select()
            .eq('u_id', user.id)
            .single()
            .maybeSingle();
        if (userCheck == null) {
          await supabase.from('users').insert({
            'u_id': user.id,
            'email': user.email,
            'username': user.userMetadata?['username'] ?? 'Unknown',
          });
        }
      }
      return right(null);
    } catch (e) {
      return left(AuthFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signup(
    String email,
    String username,
    String password,
  ) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {"username": username},
      );

      return right(null);
    } catch (e) {
      return left(AuthFailure.fromException(e));
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await supabase.auth.signOut();
      return right(null);
    } catch (e) {
      return left(AuthFailure.fromException(e));
    }
  }
}
