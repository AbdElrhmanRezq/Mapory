import 'package:dartz/dartz.dart';
import 'package:mapory/core/errors/failures.dart';
import 'package:mapory/core/utils/service_locator.dart';
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
}
