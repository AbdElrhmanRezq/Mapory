import 'package:dartz/dartz.dart';
import 'package:mapory/core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void>> signup(
    String email,
    String username,
    String password,
  );
}
