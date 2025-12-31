import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

abstract class UserPhotosRepo {
  Future<List<UserModel>> getPhotosLikes({required String photoId});
  Future<void> createMemory({
    required List<String> urls,
    required String caption,
    required LatLng position,
    String visibility = "private",
  });
}
