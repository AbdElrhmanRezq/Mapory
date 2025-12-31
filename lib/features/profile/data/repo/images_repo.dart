import 'package:image_cropper/image_cropper.dart';

abstract class ImagesRepo {
  Future<String> uploadImage(String type, CroppedFile file, String storagePath);
  Future<void> updateImageData(String imageUrl, String type);
}
