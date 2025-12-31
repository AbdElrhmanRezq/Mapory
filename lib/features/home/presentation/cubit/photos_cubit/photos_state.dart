part of 'photos_cubit.dart';

@immutable
sealed class PhotosState {}

final class PhotosInitial extends PhotosState {}

final class PhotosLoading extends PhotosState {}

final class PhotosLoaded extends PhotosState {}

final class PhotosError extends PhotosState {
  String message;
  PhotosError(this.message);
}
