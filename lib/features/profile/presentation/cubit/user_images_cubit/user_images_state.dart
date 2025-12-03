part of 'user_images_cubit.dart';

@immutable
sealed class UserImagesState {}

final class UserImagesInitial extends UserImagesState {}

final class UserImagesUploading extends UserImagesState {
  final String type;

  UserImagesUploading(this.type);
}

final class UserImagesUploaded extends UserImagesState {
  final String? imageUrl;
  UserImagesUploaded({this.imageUrl});
}

final class UserImagesError extends UserImagesState {
  final String message;
  UserImagesError(this.message);
}
