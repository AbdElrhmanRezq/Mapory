import 'package:bloc/bloc.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final UserRepo userRepo;
  UserDataCubit(this.userRepo) : super(UserDataInitial());
  Future<void> fetchUserData() async {
    emit(UserDataLoading());
    final result = await userRepo.getUserData();
    final photosCount = await userRepo.getUserPhotosCount(visibility: 'public');
    final likesCount = await userRepo.getLikesCount();
    result.fold(
      (failure) => emit(UserDataError(failure.message)),
      (userData) => emit(UserDataLoaded(userData, photosCount, likesCount)),
    );
  }

  Future<void> changeUserName(String newName) async {
    emit(UserDataLoading());
    final result = await userRepo.changeUserName(newName);
    final photosCount = await userRepo.getUserPhotosCount();
    final likesCount = await userRepo.getLikesCount();
    result.fold(
      (failure) => emit(UserDataError(failure.message)),
      (userData) => emit(UserDataLoaded(userData, photosCount, likesCount)),
    );
  }
}
