import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/repo/user_photos_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserPhotosRepoImpl implements UserPhotosRepo {
  @override
  Future<int> getUserPhotosCount() async {
    final supabase = getIt<SupabaseClient>();
    final userId = supabase.auth.currentUser?.id ?? '';

    final countResponse = await supabase.rpc(
      'photos_count_by_user',
      params: {'u_id': userId},
    );

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
