import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/functions/time_ago.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/presentation/cubit/comments_cubit/comments_cubit.dart';

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoading && state is! CommentsInitial) {
          return Center(child: CircularProgressIndicator(color: KMainColor));
        } else if (state is CommentsFailure) {
          return Center(child: Text('Failed to load comments'));
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.read<CommentsCubit>().comments.length,
            itemBuilder: (context, index) {
              final comment = context.read<CommentsCubit>().comments.elementAt(
                index,
              );
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(comment.userProfilePic),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.userName, style: Styles.textStyle16),
                          const SizedBox(height: 4),
                          Text(comment.text, style: Styles.textStyle14),
                          const SizedBox(height: 4),
                          Text(
                            timeAgo(comment.createdAt),
                            style: Styles.textStyle14.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
