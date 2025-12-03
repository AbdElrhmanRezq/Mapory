part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataLoaded extends UserDataState {
  final UserModel userData;
  final int photosCount;
  final int likesCount;
  UserDataLoaded(this.userData, this.photosCount, this.likesCount);
}

final class UserDataError extends UserDataState {
  final String message;
  UserDataError(this.message);
}
