import 'package:bloc/bloc.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'external_user_state.dart';

class ExternalUserCubit extends Cubit<ExternalUserState> {
  final UserRepo userRepo;
  ExternalUserCubit(this.userRepo) : super(ExternalUserInitial());
  Future<void> fetchUserData({required String userId}) async {
    emit(ExternalUserLoading());
    final result = await userRepo.getUserData(id: userId);
    final memoriesCount = await userRepo.getUserMemoriesCount(id: userId);
    final likesCount = await userRepo.getLikesCount(id: userId);
    result.fold(
      (failure) => emit(ExternalUserError(failure.message)),
      (userData) =>
          emit(ExternalUserLoaded(userData, memoriesCount, likesCount)),
    );
  }
}
