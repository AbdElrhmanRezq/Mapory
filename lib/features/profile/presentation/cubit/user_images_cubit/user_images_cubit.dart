import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mapory/core/utils/image_helper.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/profile/data/repo/images_repo_impl.dart';
import 'package:meta/meta.dart';

part 'user_images_state.dart';

class UserImagesCubit extends Cubit<UserImagesState> {
  final ImagesRepoImpl imagesRepo = getIt<ImagesRepoImpl>();
  final ImageHelper imageHelper = getIt<ImageHelper>();
  final ImageCropper imageCropper = getIt<ImageCropper>();

  UserImagesCubit() : super(UserImagesInitial());
  Future<void> uploadUserImage(String type) async {
    try {
      emit(UserImagesUploading(type));
      final CroppedFile? croppedImage;
      final file = await imageHelper.pickImage();
      if (file != null) {
        croppedImage = await imageHelper.crop(file: file);
        if (croppedImage == null) {
          emit(UserImagesError('Image cropping cancelled'));
          return;
        } else {
          emit(UserImagesInitial());
        }

        final imageUrl = await imagesRepo.uploadImage(type, croppedImage);

        await imagesRepo.updateImageData(imageUrl, type);
        emit(UserImagesUploaded(imageUrl: imageUrl));
      } else {
        emit(UserImagesInitial());
      }
    } catch (e) {
      emit(UserImagesError(e.toString()));
    }
  }
}
