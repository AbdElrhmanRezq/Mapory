import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:mapory/core/utils/functions/time_ago.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/profile/presentation/cubit/external_user_cubit/external_user_cubit.dart';

class MemoryUserInfo extends StatelessWidget {
  const MemoryUserInfo({super.key, required this.memory});

  final MemoryModel memory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: BlocBuilder<ExternalUserCubit, ExternalUserState>(
        builder: (context, state) {
          if (state is ExternalUserLoaded) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(
                      context,
                    ).push(AppRouter.kPublicProfile, extra: state.userData);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: KMainColor, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 30, // inner radius
                      backgroundImage: NetworkImage(
                        state.userData.profileImage,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push(AppRouter.kPublicProfile, extra: state.userData);
                      },
                      child: Text(
                        state.userData.username,
                        style: Styles.textStyle20.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 1,
                      child: Text(
                        timeAgo(memory.createdAt),
                        style: Styles.textStyle14.copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Text(memory.userId, style: Styles.textStyle16);
          }
        },
      ),
    );
  }
}
