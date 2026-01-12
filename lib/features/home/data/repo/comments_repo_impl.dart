import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/comment_model.dart';
import 'package:mapory/features/home/data/repo/comments_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsRepoImpl implements CommentsRepo {
  @override
  Future<CommentModel> addComment({
    required String memoryId,
    required String text,
  }) async {
    final SupabaseClient supabase = getIt<SupabaseClient>();

    final response = await supabase.from('comments').insert({
      'm_id': memoryId,
      'u_id': supabase.auth.currentUser!.id,
      'text': text,
    }).select();

    return CommentModel.fromJson(response.first);
  }

  @override
  Future<List<CommentModel>> fetchComments({
    required String memoryId,
    int limit = 10,
    int offset = 0,
  }) async {
    final SupabaseClient supabase = getIt<SupabaseClient>();
    final response = await supabase
        .from('comments')
        .select('''
      c_id,
      created_at,
      u_id,
      m_id,
      text,
      users (
        username,
        profile_image
      )
    ''')
        .eq('m_id', memoryId)
        .range(offset, offset + limit - 1);

    return response.map((json) => CommentModel.fromJson(json)).toList();
  }

  @override
  Future<int> fetchCommentsCount({required String memoryId}) async {
    final supabase = getIt<SupabaseClient>();

    final count = await supabase.rpc(
      'comments_count',
      params: {'_m_id': memoryId},
    );

    return count as int;
  }
}
