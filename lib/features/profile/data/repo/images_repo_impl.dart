import 'package:image_cropper/image_cropper.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/profile/data/repo/images_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImagesRepoImpl implements ImagesRepo {
  final supabase = getIt<SupabaseClient>();
  @override
  Future<void> updateImageData(String imageUrl, String type) async {
    try {
      final String currentUser = supabase.auth.currentUser?.id ?? '';
      await supabase
          .from('users')
          .update({type: imageUrl})
          .eq('u_id', currentUser);
    } on PostgrestException catch (e) {
      print('PostgrestException: ${e.message}');
      throw e;
    } catch (e) {
      print('Unknown error: $e');
      throw e;
    }
  }

  @override
  Future<String> uploadImage(
    String type,
    CroppedFile file,
    String storagePath,
  ) async {
    try {
      final imageExtension = file.path.split('.').last.toLowerCase();
      final imageBytes = await file.readAsBytes();

      final imagePath =
          '${supabase.auth.currentUser?.id}/$type.$imageExtension';
      print(imagePath);
      await supabase.storage
          .from(storagePath)
          .uploadBinary(
            imagePath,
            imageBytes,
            fileOptions: FileOptions(
              upsert: true,
              contentType: 'image/$imageExtension',
            ),
          );

      print('Image uploaded: $imagePath');

      return supabase.storage.from(storagePath).getPublicUrl(imagePath);
    } on PostgrestException catch (e) {
      print('PostgrestException: ${e.message}');
      throw e;
    } catch (e) {
      print('Unknown error: $e');
      throw e;
    }
  }
}
