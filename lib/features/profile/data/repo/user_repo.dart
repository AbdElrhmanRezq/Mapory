import 'package:dartz/dartz.dart';
import 'package:mapory/core/errors/failures.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, UserModel>> changeUserName(String newName);
}
