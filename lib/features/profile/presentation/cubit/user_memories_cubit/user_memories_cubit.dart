import 'package:bloc/bloc.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/data/repo/memories_repo.dart';
import 'package:meta/meta.dart';

part 'user_memories_state.dart';

class UserMemoriesCubit extends Cubit<UserMemoriesState> {
  int offset = 0;
  List<MemoryModel> memories = [];
  final MemoriesRepo memoriesRepo;
  UserMemoriesCubit(this.memoriesRepo) : super(UserMemoriesInitial());
  Future<List<MemoryModel>> fetchUserMemories({int limit = 11}) async {
    emit(UserMemoriesLoading());
    try {
      final loadedMemories = await memoriesRepo.getUserMemories(
        limit: limit,
        offset: offset,
      );
      memories.addAll(loadedMemories);
      offset++;
      emit(UserMemoriesLoaded());
      return memories;
    } catch (e) {
      emit(UserMemoriesError(e.toString()));
      return [];
    }
  }
}
