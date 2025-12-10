import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

abstract class UserPhotosRepo {
  Future<int> getUserPhotosCount({String visibility = 'all'});
  Future<List<UserModel>> getPhotosLikes({required String photoId});
}
