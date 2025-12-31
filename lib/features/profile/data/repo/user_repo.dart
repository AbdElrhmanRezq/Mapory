import 'package:dartz/dartz.dart';
import 'package:mapory/core/errors/failures.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> getUserData({String id = ''});
  Future<Either<Failure, UserModel>> changeUserName(String newName);
  Future<int> getUserPhotosCount({String id = ''});
  Future<int> getLikesCount({String id = ''});
  Future<List<PhotoModel>> getUserPhotos({
    required int limit,
    required int offset,
  });

  Future<List<PhotoModel>> getPhotosByMemoryId({required String memoryId});
  Future<Either<Failure, List<MemoryModel>>> getUserMemories({
    required int limit,
    required int offset,
  });
}
