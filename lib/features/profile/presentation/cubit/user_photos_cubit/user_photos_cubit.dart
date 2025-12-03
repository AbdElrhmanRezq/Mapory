import 'package:bloc/bloc.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'user_photos_state.dart';

class UserPhotosCubit extends Cubit<UserPhotosState> {
  final UserRepo userRepo;
  List<PhotoModel> photos = [];

  UserPhotosCubit(this.userRepo) : super(UserPhotosInitial());

  Future<List<PhotoModel>> fetchUserPhotos({
    int limit = 10,
    int offset = 0,
  }) async {
    emit(UserPhotosLoading());
    try {
      final loadedPhotos = await userRepo.getUserPhotos(
        limit: limit,
        offset: offset,
      );
      photos.addAll(loadedPhotos);
      emit(UserPhotosLoaded());
      return photos;
    } catch (e) {
      emit(UserPhotosError(e.toString()));
      return [];
    }
  }
}
