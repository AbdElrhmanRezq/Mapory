import 'package:mapory/features/home/data/models/comment_model.dart';

abstract class CommentsRepo {
  Future<List<CommentModel>> fetchComments({
    required String memoryId,
    int limit = 10,
    int offset = 0,
  });
  Future<CommentModel> addComment({
    required String memoryId,
    required String text,
  });
  Future<int> fetchCommentsCount({required String memoryId});
}
