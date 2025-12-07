import 'package:dartz/dartz.dart';
import 'package:mapory/core/errors/failures.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, UserModel>> changeUserName(String newName);
  Future<int> getUserPhotosCount({String visibility = 'all'});
  Future<int> getLikesCount();
  Future<List<PhotoModel>> getUserPhotos({
    required int limit,
    required int offset,
  });
}
