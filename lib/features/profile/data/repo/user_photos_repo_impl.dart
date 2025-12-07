import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/repo/user_photos_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserPhotosRepoImpl implements UserPhotosRepo {
  @override
  Future<int> getUserPhotosCount({String visibility = 'all'}) async {
    final supabase = getIt<SupabaseClient>();
    final userId = supabase.auth.currentUser?.id ?? '';
    final countResponse;
    if (visibility == 'all') {
      countResponse = await supabase.rpc(
        'photos_count_by_user',
        params: {'u_id': userId},
      );
    } else {
      countResponse = await supabase.rpc(
        'photos_count_by_user',
        params: {'u_id': userId, 'visibility': "public"},
      );
    }

    final count = countResponse as int? ?? 0;

    return count;
  }

  @override
  Future<List<PhotoModel>> getUserPhotos({
    required int limit,
    required int offset,
  }) {
    // TODO: implement getUserPhotos
    throw UnimplementedError();
  }
}
