part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataLoaded extends UserDataState {
  final UserModel userData;
  UserDataLoaded(this.userData);
}

final class UserDataError extends UserDataState {
  final String message;
  UserDataError(this.message);
}
