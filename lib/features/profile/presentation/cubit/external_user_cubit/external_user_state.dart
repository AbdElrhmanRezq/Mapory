part of 'external_user_cubit.dart';

@immutable
sealed class ExternalUserState {}

final class ExternalUserInitial extends ExternalUserState {}

final class ExternalUserLoading extends ExternalUserState {}

final class ExternalUserLoaded extends ExternalUserState {
  final UserModel userData;
  final int memoriesCount;

  ExternalUserLoaded(this.userData, this.memoriesCount);
}

final class ExternalUserError extends ExternalUserState {
  final String message;
  ExternalUserError(this.message);
}
