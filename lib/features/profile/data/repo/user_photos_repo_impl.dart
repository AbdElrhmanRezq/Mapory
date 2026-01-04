import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_photos_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserPhotosRepoImpl implements UserPhotosRepo {
  @override
  Future<List<UserModel>> getPhotosLikes({required String photoId}) async {
    final supabase = getIt<SupabaseClient>();
    final data = await supabase
        .from('likes')
        .select('users!likes_liker_id_fkey(*)')
        .eq('p_id', photoId);

    final List<UserModel> users = [];
    final records = data as List<dynamic>;
    records.forEach((record) {
      users.add(UserModel.fromMap(record));
    });

    return users;
  }
}
