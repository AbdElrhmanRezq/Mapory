part of 'user_memories_cubit.dart';

@immutable
sealed class UserMemoriesState {}

final class UserMemoriesInitial extends UserMemoriesState {}

final class UserMemoriesLoading extends UserMemoriesState {}

final class UserMemoriesLoaded extends UserMemoriesState {}

final class UserMemoriesError extends UserMemoriesState {
  final String message;
  UserMemoriesError(this.message);
}
