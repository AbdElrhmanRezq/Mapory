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

  @override
  Future<void> createMemory({
    required List<String> urls,
    required String caption,
    required LatLng position,
    String visibility = "private",
  }) async {
    final supabase = getIt<SupabaseClient>();
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('memories')
        .insert({
          'u_id': userId,
          'caption': caption,
          'lat': position.latitude,
          'long': position.longitude,
          'created_at': DateTime.now().toIso8601String(),
          'visibility': visibility,
        })
        .select()
        .single();
    await supabase
        .from('photos')
        .insert(
          urls.map((url) {
            return {
              'u_id': userId,
              'image_url': url,
              'created_at': DateTime.now().toIso8601String(),
              'm_id': data['m_id'],
            };
          }).toList(),
        );
  }
}
