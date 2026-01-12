import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mapory/features/home/data/models/comment_model.dart';
import 'package:mapory/features/home/data/repo/comments_repo.dart';
import 'package:meta/meta.dart';

part 'user_comment_state.dart';

class UserCommentCubit extends Cubit<UserCommentState> {
  final TextEditingController commentController = TextEditingController();
  final CommentsRepo commentsRepo;
  UserCommentCubit(this.commentsRepo) : super(UserCommentInitial());
  Future<void> addComment({required String memoryId}) async {
    try {
      emit(UserCommentSending());
      final CommentModel comment = await commentsRepo.addComment(
        memoryId: memoryId,
        text: commentController.text,
      );
      emit(UserCommentSent(comment: comment));
      await Future.delayed(Duration(seconds: 2));
      commentController.clear();
      emit(UserCommentInitial());
    } catch (e) {
      emit(UserCommentFailure(errorMessage: e.toString()));
    }
  }
}
