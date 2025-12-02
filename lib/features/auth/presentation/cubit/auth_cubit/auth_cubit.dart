import 'package:bloc/bloc.dart';
import 'package:mapory/features/auth/data/repo/auth_repo_impl.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImpl authRepoImpl;
  AuthCubit(this.authRepoImpl) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    print("Heloooooooooo");
    emit(AuthLoading());
    final result = await authRepoImpl.login(email, password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSignedIn()),
    );
  }

  Future<void> signup(String email, String username, String password) async {
    emit(AuthLoading());
    final result = await authRepoImpl.signup(email, username, password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSignedUp()),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await authRepoImpl.logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSignedOut()),
    );
  }
}
