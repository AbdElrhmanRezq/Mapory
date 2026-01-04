import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapory/core/utils/image_helper.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/repo/memories_repo.dart';
import 'package:mapory/features/profile/data/repo/images_repo_impl.dart';
import 'package:mapory/features/profile/data/repo/user_photos_repo.dart';
import 'package:mapory/features/profile/data/repo/user_photos_repo_impl.dart';
import 'package:meta/meta.dart';

part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  List<CroppedFile> photos = [];
  List<XFile> pickedphotos = [];
  TextEditingController captionController = TextEditingController();
  final LatLng position;
  final ImageHelper imageHelper = getIt<ImageHelper>();
  final ImageCropper imageCropper = getIt<ImageCropper>();
  PhotosCubit(this.position) : super(PhotosInitial());
  Future<void> loadImagesFromDevice() async {
    try {
      emit(PhotosLoading());
      final List<CroppedFile> croppedImages = [];
      final List<XFile> files = await imageHelper.pickMultipleImages();

      for (final file in files) {
        final CroppedFile? croppedImage = await imageHelper.crop(file: file);

        if (croppedImage != null) {
          croppedImages.add(croppedImage);
        }
      }

      photos = croppedImages;
      emit(PhotosLoaded());
    } catch (e) {
      emit(PhotosError(e.toString()));
    }
  }

  Future<void> uploadPhotos() async {
    try {
      final ImagesRepoImpl imagesRepo = getIt<ImagesRepoImpl>();
      final List<String> urls = [];
      emit(PhotosUploading());
      for (int i = 0; i < photos.length; i++) {
        String url = await imagesRepo.uploadImage(
          "${DateTime.now()}-${i}",
          photos[i],
          "photos",
        );
        urls.add(url);
      }
      createMemory(photosUrls: urls);
    } catch (e) {
      emit(PhotosError(e.toString()));
    }
  }

  Future<void> createMemory({
    required List<String> photosUrls,
    String visibility = "private",
  }) async {
    final MemoriesRepo memoriesRepo = getIt<MemoriesRepo>();
    try {
      memoriesRepo.createMemory(
        urls: photosUrls,
        caption: captionController.text,
        position: position,
        visibility: visibility,
      );
    } catch (e) {
      emit(PhotosError(e.toString()));
    }
  }
}
