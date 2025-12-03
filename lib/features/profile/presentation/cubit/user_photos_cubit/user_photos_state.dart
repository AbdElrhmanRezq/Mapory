part of 'user_photos_cubit.dart';

@immutable
sealed class UserPhotosState {}

final class UserPhotosInitial extends UserPhotosState {}

final class UserPhotosError extends UserPhotosState {
  final String message;
  UserPhotosError(this.message);
}

final class UserPhotosLoaded extends UserPhotosState {}

final class UserPhotosLoading extends UserPhotosState {}
