import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_memories_cubit/user_memories_cubit.dart';
import 'package:mapory/features/profile/presentation/cubit/user_photos_cubit/user_photos_cubit.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/photos_grid.dart';

class UserMemories extends StatelessWidget {
  final int totalMemories;
  const UserMemories({super.key, required this.totalMemories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<UserMemoriesCubit, UserMemoriesState>(
          builder: (context, state) {
            if (state is UserMemoriesLoaded) {
              List<MemoryModel> photos = BlocProvider.of<UserMemoriesCubit>(
                context,
              ).memories;
              return MemoriesGrid(
                totalMemories: totalMemories,
                memories: photos,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
