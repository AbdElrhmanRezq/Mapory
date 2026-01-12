import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mapory/core/errors/failures.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/comment_model.dart';
import 'package:mapory/features/home/data/repo/comments_repo.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo.dart';
import 'package:mapory/features/profile/data/repo/user_repo_impl.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentsRepo commentsRepo;
  int offset = 0;
  Set<CommentModel> comments = {};
  bool isLoading = false;
  bool hasMore = true;

  CommentsCubit(this.commentsRepo) : super(CommentsInitial());
  Future<void> fetchComments({required String memoryId}) async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    emit(CommentsLoading());
    try {
      final fetchedComments = await commentsRepo.fetchComments(
        memoryId: memoryId,
        offset: offset,
      );
      if (fetchedComments.isEmpty) {
        hasMore = false;
      } else {
        comments.addAll(fetchedComments);
        offset += fetchedComments.length;
      }
      emit(CommentsLoaded());
    } catch (e) {
      emit(CommentsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> addComment(CommentModel comment) async {
    try {
      final Either<Failure, UserModel> data = await getIt
          .get<UserRepoImpl>()
          .getUserData(id: comment.uId);

      late UserModel user;

      data.fold((l) => throw Exception(l), (r) => user = r);

      final commentWithUser = comment.copyWith(
        userName: user.username,
        userProfilePic: user.profileImage,
      );

      comments.add(commentWithUser);

      emit(CommentsLoaded());
    } catch (e) {
      emit(CommentsFailure(errorMessage: e.toString()));
    }
  }
}
