part of 'user_comment_cubit.dart';

@immutable
sealed class UserCommentState {}

final class UserCommentInitial extends UserCommentState {}

final class UserCommentSending extends UserCommentState {}

final class UserCommentSent extends UserCommentState {
  final CommentModel comment;
  UserCommentSent({required this.comment});
}

final class UserCommentFailure extends UserCommentState {
  final String errorMessage;
  UserCommentFailure({required this.errorMessage});
}
