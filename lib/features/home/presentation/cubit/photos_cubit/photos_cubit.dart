import 'package:bloc/bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapory/core/utils/image_helper.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  List<CroppedFile> images = [];
  List<XFile> pickedImages = [];
  final ImageHelper imageHelper = getIt<ImageHelper>();
  final ImageCropper imageCropper = getIt<ImageCropper>();
  PhotosCubit() : super(PhotosInitial());
  Future<void> loadImagesFromDevice() async {
    try {
      emit(PhotosLoading());
      final List<CroppedFile> croppedImages = [];
      final List<XFile> files = await imageHelper.pickMultipleImages();
      if (files != null) {
        files.forEach((file) async {
          CroppedFile croppedImage =
              await imageHelper.crop(file: file) as CroppedFile;
          croppedImages.add(croppedImage);
          if (croppedImage != null) {
            images.add(croppedImage);
          }
        });
        if (croppedImages.isEmpty) {
          emit(PhotosError('Image cropping cancelled'));
          return;
        } else {
          images = croppedImages;
          emit(PhotosLoaded());
        }
      }
    } catch (e) {
      emit(PhotosError(e.toString()));
    }
  }
}
