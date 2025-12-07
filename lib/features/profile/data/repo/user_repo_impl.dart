import 'package:dartz/dartz.dart';
import 'package:mapory/core/errors/failures.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepoImpl implements UserRepo {
  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      final supabase = getIt<SupabaseClient>();
      final user = supabase.auth.currentUser;
      final data = await supabase
          .from('users')
          .select()
          .eq('u_id', user?.id ?? '')
          .single();
      final userModel = UserModel.fromMap(data);
      return right(userModel);
    } catch (e) {
      return left(DataFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> changeUserName(String newName) async {
    try {
      final supabase = getIt<SupabaseClient>();
      final user = supabase.auth.currentUser;
      final data = await supabase
          .from('users')
          .update({'username': newName})
          .eq('u_id', user?.id ?? '')
          .select()
          .single();
      final userModel = UserModel.fromMap(data);
      return right(userModel);
    } catch (e) {
      print(e);
      return left(DataFailure.fromException(e));
    }
  }

  @override
  Future<int> getUserPhotosCount({String visibility = 'all'}) async {
    final supabase = getIt<SupabaseClient>();
    final userId = supabase.auth.currentUser?.id ?? '';
    final countResponse;
    if (visibility == 'all') {
      countResponse = await supabase.rpc(
        'photos_count_by_user',
        params: {'_u_id': userId},
      );
    } else {
      countResponse = await supabase.rpc(
        'photos_count_by_user',
        params: {'_u_id': userId, '_visibility': "public"},
      );
    }

    final count = countResponse as int? ?? 0;

    return count;
  }

  @override
  Future<int> getLikesCount() async {
    final supabase = getIt<SupabaseClient>();
    final user = supabase.auth.currentUser;
    final data = await supabase
        .from('likes')
        .select()
        .eq('author_id', user?.id ?? '');
    final records = data as List<dynamic>;

    return records.length;
  }

  @override
  Future<List<PhotoModel>> getUserPhotos({
    required int limit,
    required int offset,
  }) {
    return Future(() async {
      final supabase = getIt<SupabaseClient>();
      final user = supabase.auth.currentUser;
      final int start = offset * limit;
      final int end = start + limit - 1;
      final data = await supabase
          .from('photos')
          .select()
          .eq('u_id', user?.id ?? '')
          .eq('visibility', 'public')
          .order('created_at', ascending: false)
          .range(start, end);
      final records = data as List<dynamic>;
      return records.map((photoData) => PhotoModel.fromMap(photoData)).toList();
    });
  }
}
