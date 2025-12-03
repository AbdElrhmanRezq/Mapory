import 'package:mapory/features/home/data/models/photo_model.dart';

abstract class UserPhotosRepo {
  Future<int> getUserPhotosCount();
  Future<List<PhotoModel>> getUserPhotos({
    required int limit,
    required int offset,
  });
}
