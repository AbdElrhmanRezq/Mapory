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
      return right(null);
    } catch (e) {
      print(e);

      return left(ServerFailure("Something"));
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
      print(e);
      return left(ServerFailure("Something"));
    }
  }
}
