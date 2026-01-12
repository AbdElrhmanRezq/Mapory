import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/comment_model.dart';
import 'package:mapory/features/home/data/repo/comments_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsRepoImpl implements CommentsRepo {
  @override
  Future<void> addComment({
    required String memoryId,
    required String text,
  }) async {
    final SupabaseClient supabase = getIt<SupabaseClient>();

    await supabase.from('comments').insert({
      'm_id': memoryId,
      'u_id': supabase.auth.currentUser!.id,
      'text': text,
    });
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
        .select()
        .eq('m_id', memoryId)
        .range(offset, offset + limit - 1);

    return response.map((json) => CommentModel.fromJson(json)).toList();
  }
}
