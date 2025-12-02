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
    result.fold(
      (failure) => emit(UserDataError(failure.message)),
      (userData) => emit(UserDataLoaded(userData)),
    );
  }
}
